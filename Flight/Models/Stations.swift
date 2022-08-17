//
//  Stations.swift
//  Flight
//
//  Created by ARCHER on 17/08/2022.
//

import Foundation

// MARK: - Stations
struct Stations: Codable {
    let stations: [Station]
}

// MARK: - Station
struct Station: Codable {
    let code, name: String?
    let alternateName: String?
    let alias: [String]?
    let countryCode, countryName: String?
    let countryGroupCode, countryGroupName, timeZoneCode, latitude: String?
    let longitude: String?
    let mobileBoardingPass: Bool?
    let markets: [Market]
    let tripCardImageURL: String?
    let airportShopping: Bool?

    enum CodingKeys: String, CodingKey {
        case code, name, alternateName, alias, countryCode, countryName, countryGroupCode, countryGroupName, timeZoneCode, latitude, longitude, mobileBoardingPass, markets
        case tripCardImageURL = "tripCardImageUrl"
        case airportShopping
    }
}

// MARK: - Market
struct Market: Codable {
    let code: String?
    let group: String?
    let stops: [Stop]?
    let onlyConnecting, pendingApproval, onlyPrintedBoardingPass: Bool?
}

// MARK: - Stop
struct Stop: Codable {
    let code: String?
}
