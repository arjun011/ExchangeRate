//
//  LatestRateDataModel.swift
//  ExchangeRate
//
//  Created by Arjun on 21/04/22.
//

import Foundation

// MARK: - LatestRatesDataModel
struct LatestRatesDataModel: Codable {
    var motd: MOTD?
    var success: Bool?
    var base, date: String?
    var rates: [String: Double] = [String: Double]()
}

// MARK: - MOTD
struct MOTD: Codable {
    var msg: String?
    var url: String?
}
