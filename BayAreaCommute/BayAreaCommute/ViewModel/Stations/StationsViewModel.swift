//
//  StationsViewModel.swift
//  BayAreaCommute
//
//  Created by Karthik on 5/18/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

import UIKit

final class StationsViewModel {

    // MARK: - Properties
    let stations: [Station]
    var isFiltering: Bool = false

    private var filteredStations: [Station] = []

    init(stations: [Station]) {
        self.stations = stations
    }

    var numberOfSections: Int { return 1 }
    var numberOfRowsInSections: Int {
        if isFiltering { return filteredStations.count }
        return stations.count
    }

    // MARK: - Public methods
    func getStationName(at indexPath: IndexPath) -> String {
        let station = getStationAt(indexPath: indexPath)
        return station.name
    }

    func getStationAt(indexPath: IndexPath) -> Station {
        if isFiltering { return filteredStations[indexPath.row] }
        return stations[indexPath.row]
    }

    func filterContentFor(_ searchText: String) {
        filteredStations = stations.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
}
