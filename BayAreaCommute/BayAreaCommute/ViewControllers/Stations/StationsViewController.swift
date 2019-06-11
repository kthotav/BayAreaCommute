//
//  StationsViewController.swift
//  BayAreaCommute
//
//  Created by Karthik on 5/15/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

import UIKit

final class StationsViewController: UIViewController {

    // MARK: - Constants
    private struct Constants {
        static let searchBarPlaceholder = "Search stations"
        static let title = "Stations"
    }

    // MARK: - Properties
    var viewModel: StationsViewModel!

    // MARK: - Views
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.searchBarPlaceholder
        return searchController
    }()

    lazy var stationsView: StationsView? = {
        let stationsView = StationsView()
        stationsView.stationsTableView.delegate = self
        stationsView.stationsTableView.dataSource = self
        return stationsView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = stationsView
        view.backgroundColor = .white
        title = Constants.title
        definesPresentationContext = true
        navigationItem.searchController = searchController
        fetchStationsData()
    }

    private func fetchStationsData() {
        guard let stations = Networking.service.getBartStations() else { return }
        viewModel = StationsViewModel(stations: stations)
        stationsView?.stationsTableView.reloadData()
    }
}

extension StationsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        viewModel.isFiltering = searchController.isActive && !searchText.isEmpty
        viewModel.filterContentFor(searchText)
        stationsView?.stationsTableView.reloadData()
    }
}

extension StationsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSections
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel.getStationName(at: indexPath)
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension StationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        let station = viewModel.getStationAt(indexPath: indexPath)
        let stationDetailVC = StationDetailViewController(station: station)
        navigationController?.pushViewController(stationDetailVC, animated: true)
    }
}
