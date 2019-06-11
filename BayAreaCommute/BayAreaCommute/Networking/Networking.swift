//
//  Networking.swift
//  BayAreaCommute
//
//  Created by Karthik on 5/19/19.
//  Copyright © 2019 Karthik. All rights reserved.
//

import Foundation

class Networking {
    static let service: Networking = Networking()

    private var urlComponents: URLComponents = {
        var urlComp = URLComponents()
        urlComp.scheme = "http"
        urlComp.host = "api.bart.gov"
        urlComp.path = "/api/etd.aspx"
        return urlComp
    }()
    private let session: URLSession = URLSession(configuration: .default)

    func getBartStations() -> [Station]? {
        guard let path = Bundle.main.path(forResource: "bart_stations", ofType: "json") else { return nil }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()

            let json = try decoder.decode(StationsDecodable.self, from: data)
            var stations: [Station] = [Station]()
            json.station.forEach {
                let station = Station(name: $0.name ?? "",
                                abbr: $0.abbr ?? "",
                                latitude: $0.latitude ?? "",
                                longitude: $0.longitude ?? "",
                                address: $0.address ?? "",
                                city: $0.city ?? "",
                                county: $0.county ?? "",
                                state: $0.state ?? "",
                                zipcode: $0.zipcode ?? "",
                                etd: $0.etd ?? [])
                stations.append(station)
            }
            return stations
        } catch let error {
            print(error.localizedDescription)
        }
        return nil
    }

    func getRealTimeSchedule(for abbr: String, completition: @escaping ([StationDetail]) -> Void) {

        let queryItems =  [
            URLQueryItem(name: "key", value: "MW9S-E7SL-26DU-VV8V"),
            URLQueryItem(name: "json", value: "y"),
            URLQueryItem(name: "cmd", value: "etd"),
            URLQueryItem(name: "orig", value: abbr)
        ]
        urlComponents.queryItems = queryItems

        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        print("URL: \(url.absoluteString)")
        let task = session.dataTask(with: request) { (data, response, error) in

            if let error = error {
                print("ERROR: \(error.localizedDescription) in \(#function), \(#line)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("ERROR: HTTPResponse.statusCode in \(#function), \(#line)")
                    return
            }

            if let data = data {

                do {
                    let decoder = JSONDecoder()
                    let schedule = try decoder.decode(EstimatedDepartureDecodable.self, from: data)
                    guard let station = schedule.station.first else { return }
                    let estimatedDepartures = station.etd ?? []
                    let stationDetails = self.createStationDetail(with: estimatedDepartures)
                    completition(stationDetails)
                } catch let error {
                    print("Error: \(error.localizedDescription)")
                }

                return
            }

        }
        task.resume()

    }
}

/*
 let session = URLSession(configuration: .default)
 let urlReq = URLRequest(url: URL(string:
 "http://api.bart.gov/api/etd.aspx?cmd=etd&orig=RICH&key=MW9S-E7SL-26DU-VV8V&json=y")!)
 let task = session.dataTask(with: urlReq) { (data, response, error) in
 if let error = error {
 print("Error: \(error.localizedDescription)")
 }

 if let data = data {
 do {
 let decoder = JSONDecoder()
 let data = try decoder.decode(RealTimeSchedule.self, from: data)
 print(data)
 } catch let error {
 print("Error: \(error.localizedDescription)")
 }
 }
 }
 task.resume()
 */
extension Networking {
    private func createStationDetail(with etd: [EstimatedDeparture]) -> [StationDetail] {
        let stationDetail = getStationDetail(with: etd)
        return stationDetail
    }

    private func getStationDetail(with etd: [EstimatedDeparture]) -> [StationDetail] {
        var stationDetail: [StationDetail] = [StationDetail]()
        etd.forEach {
            var platforms: Set<Int> = Set<Int>()
            var minutes: [String] = []
            let estimates = $0.estimate
            estimates.forEach {
                if !platforms.contains(Int($0.platform) ?? 0) {
                    platforms.insert(Int($0.platform) ?? 0)
                }
                minutes.append($0.minutes)
            }
            let std = StationDetail(destination: $0.destination,
                                    plaform: Platform(rawValue: platforms.removeFirst()) ?? .none, estimates: minutes)
            stationDetail.append(std)

        }
        return stationDetail
    }

    private func getPlatforms(with platformsSet: Set<Int>) -> [Platform] {
        let sortedSet = platformsSet.sorted()
        return sortedSet.map { Platform(rawValue: $0) }.compactMap { return $0 }
    }
}
