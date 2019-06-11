//
//  EstimatedDepartureDecodable.swift
//  BayAreaCommute
//
//  Created by Karthik on 5/30/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

struct EstimatedDepartureDecodable: Decodable {
    let station: [StationDecodable]

    enum CodingKeys: String, CodingKey {
        case root
    }

    enum RootKeys: String, CodingKey {
        case station
    }

    init(from decoder: Decoder) throws {
        // { "xml": {}, "root": { } } container
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // "root": { } container
        let rootContainer = try container.nestedContainer(keyedBy: RootKeys.self, forKey: .root)

        // "root": { "station": { } } container
        station = try rootContainer.decode([StationDecodable].self, forKey: .station)
    }
}
