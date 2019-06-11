//
//  StationDetailViewController.swift
//  BayAreaCommute
//
//  Created by Karthik on 5/19/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

import UIKit

class StationDetailViewController: UIViewController {

    // MARK: - Constants
    struct Constants {
        static let mapCellId = "MapCell"
    }

    // MARK: - Properties
    let station: Station
    var viewModel: StationDetailViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.stationDetailView.tableView.reloadData()
            }
        }
    }

    // MARK: - Views
    lazy var stationDetailView: StationDetailView = {
        return StationDetailView()
    }()

    init(station: Station) {
        self.station = station
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = stationDetailView
        title = station.name
        view.backgroundColor = .white

        fetchRealTimeSchedule(for: station.abbr)
        configureStationDetailTableView()
    }

    private func fetchRealTimeSchedule(for abbr: String?) {
        guard let abbr = abbr else { return }
        Networking.service.getRealTimeSchedule(for: abbr) { [weak self] in
            guard let self = self else { return }
            self.viewModel = StationDetailViewModel(stationDetail: $0)
        }
    }

    private func configureStationDetailTableView() {
        stationDetailView.tableView.dataSource = self
        stationDetailView.tableView.delegate = self
        stationDetailView.tableView.register(MapTableViewCell.self, forCellReuseIdentifier: Constants.mapCellId)
    }
}

extension StationDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.getNumberOfRows(for: viewModel.sections[section])
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        switch viewModel.sections[indexPath.section] {
        case .map:
            // swiftlint:disable force_cast
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.mapCellId, for: indexPath)
                as! MapTableViewCell
            return cell
        case .platformOne:
            let cell = UITableViewCell()
            cell.textLabel?.text = viewModel.getEstimates(for: .one, at: indexPath.row)
            return cell
        case .platformTwo:
            let cell = UITableViewCell()
            cell.textLabel?.text = viewModel.getEstimates(for: .two, at: indexPath.row)
            return cell
        case .platformThree:
            let cell = UITableViewCell()
            cell.textLabel?.text = viewModel.getEstimates(for: .three, at: indexPath.row)
            return cell
        case .realTimeSection:
            let cell = UITableViewCell()
            cell.textLabel?.text = "Real time"
            return cell
        }
    }
}

extension StationDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let viewModel = viewModel else { return UITableView.automaticDimension }
        switch viewModel.sections[indexPath.section] {
        case .map: return 245
        default: return UITableView.automaticDimension
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let viewModel = viewModel else { return nil }
        switch viewModel.sections[section] {
        case .map: return "Map"
        case .platformOne: return "Platform 1"
        case .platformTwo: return "Platform 2"
        case .platformThree: return "Platform 3"
        case .realTimeSection: return "Real time updates"
        }
    }
}
