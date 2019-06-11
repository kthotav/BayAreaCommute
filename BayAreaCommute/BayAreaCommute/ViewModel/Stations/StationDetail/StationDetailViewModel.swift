//
//  StationDetailViewModel.swift
//  BayAreaCommute
//
//  Created by Karthik on 5/22/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

enum StationDetailSections: Int, Comparable {
    case map = 0
    case platformOne = 1
    case platformTwo = 2
    case platformThree = 3
    case realTimeSection = 4

    static func < (lhs: StationDetailSections, rhs: StationDetailSections) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

class StationDetailViewModel {
    let stationDetail: [StationDetail]
    var sections: [StationDetailSections] = [.realTimeSection, .map]
    private var platformOneTrains: [StationDetail] = [StationDetail]()
    private var platformTwoTrains: [StationDetail] = [StationDetail]()
    private var platformThreeTrains: [StationDetail] = [StationDetail]()

    init(stationDetail: [StationDetail]) {
        self.stationDetail = stationDetail
        print(self.stationDetail)
        createSections()
    }

    func getEstimates(for plaform: Platform, at index: Int) -> String {
        switch plaform {
        case .one: return getMinutes(for: platformOneTrains[index])
        case .two: return getMinutes(for: platformTwoTrains[index])
        case .three: return getMinutes(for: platformThreeTrains[index])
        default: return ""
        }
    }

    private func getMinutes(for station: StationDetail) -> String {
        var str = ""
        let estimates = station.estimates
        estimates.forEach {
            let mins = $0
            str += "\(mins), "
        }
        return "\(station.destination) - \(str)"
    }

    private func createSections() {
        var platforms: Set<Platform> = Set<Platform>()
        stationDetail.forEach {
            platforms.insert($0.plaform)
        }
        platforms.forEach {
            switch $0 {
            case .one: sections.append(.platformOne)
            case .two: sections.append(.platformTwo)
            case .three: sections.append(.platformThree)
            default: break
            }
        }
        let sortedSections = sections.sorted()
        sections = sortedSections
        sections.forEach { filterTrainsByPlatform(for: $0) }
    }

    func filterTrainsByPlatform(for section: StationDetailSections) {
        switch section {
        case .platformOne:
            platformOneTrains = stationDetail.filter { $0.plaform == .one }
        case .platformTwo:
            platformTwoTrains = stationDetail.filter { $0.plaform == .two }
        case .platformThree:
            platformThreeTrains = stationDetail.filter { $0.plaform == .three }
        default: break
        }
    }

    func getNumberOfRows(for section: StationDetailSections) -> Int {
        switch section {
        case .map: return 1
        case .platformOne:
            return platformOneTrains.count
        case .platformTwo:
            return platformTwoTrains.count
        case .platformThree:
            return platformThreeTrains.count
        default: return 0
        }
    }
}
