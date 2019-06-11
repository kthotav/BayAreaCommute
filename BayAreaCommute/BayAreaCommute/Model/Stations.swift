//
//  Stations.swift
//  BayAreaCommute
//
//  Created by Karthik on 5/18/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

struct Station {
    let name: String
    let abbr: String
    let latitude: String
    let longitude: String
    let address: String
    let city: String
    let county: String
    let state: String
    let zipcode: String
    let etd: [EstimatedDeparture]
}
