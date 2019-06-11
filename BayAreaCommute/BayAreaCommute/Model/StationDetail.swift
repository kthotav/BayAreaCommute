//
//  StationDetail.swift
//  BayAreaCommute
//
//  Created by Karthik on 5/30/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

struct StationDetail {
    let destination: String
    let plaform: Platform
    let estimates: [String]
}

enum Platform: Int {
    case none = 0
    case one = 1
    case two = 2
    case three = 3
}
