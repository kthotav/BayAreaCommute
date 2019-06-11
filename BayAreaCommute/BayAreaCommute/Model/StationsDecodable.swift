//
//  StationsDecodable.swift
//  BayAreaCommute
//
//  Created by Karthik on 5/28/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

struct StationsDecodable: Decodable {

    let station: [StationDecodable]

    enum CodingKeys: String, CodingKey {
        case root
    }

    enum RootKeys: String, CodingKey {
        case stations
    }

    enum StationsKeys: String, CodingKey {
        case station
    }

    init(from decoder: Decoder) throws {
        // { "xml": {}, "root": { } } container
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // "root": { } container
        let rootContainer = try container.nestedContainer(keyedBy: RootKeys.self, forKey: .root)

        // "root": { "stations": { } } container
        let stationsContainer = try rootContainer.nestedContainer(keyedBy: StationsKeys.self, forKey: .stations)

        station = try stationsContainer.decode([StationDecodable].self, forKey: .station)
    }
}

struct StationDecodable: Decodable {
    let name: String?
    let abbr: String?
    let latitude: String?
    let longitude: String?
    let address: String?
    let city: String?
    let county: String?
    let state: String?
    let zipcode: String?
    let etd: [EstimatedDeparture]?

    enum CodingKeys: String, CodingKey {
        case name, abbr, address, city, county, state, zipcode, etd
        case latitude = "gtfs_latitude"
        case longitude = "gtfs_longitude"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decodeIfPresent(String.self, forKey: .name)
        abbr = try container.decodeIfPresent(String.self, forKey: .abbr)
        latitude = try container.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try container.decodeIfPresent(String.self, forKey: .longitude)
        address = try container.decodeIfPresent(String.self, forKey: .address)
        city = try container.decodeIfPresent(String.self, forKey: .city)
        county = try container.decodeIfPresent(String.self, forKey: .county)
        state = try container.decodeIfPresent(String.self, forKey: .state)
        zipcode = try container.decodeIfPresent(String.self, forKey: .zipcode)
        etd = try container.decodeIfPresent([EstimatedDeparture].self, forKey: .etd)
    }
}
