//
//  EstimatedDeparture.swift
//  BayAreaCommute
//
//  Created by Karthik on 5/30/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

struct EstimatedDeparture: Decodable {
    let destination: String
    let estimate: [Estimate]
}

struct Estimate: Decodable {
    let minutes: String
    let platform: String
    let direction: String
    let length: String
    let color: String
    let hexcolor: String
    let bikeflag: String
    let delay: String
}
