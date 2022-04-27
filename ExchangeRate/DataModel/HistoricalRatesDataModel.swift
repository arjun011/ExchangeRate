//
//  HistoricalRateDataModel.swift
//  ExchangeRate
//
//  Created by Arjun on 21/04/22.
//

import Foundation

// MARK: - HistoricalRatesDataModel
struct HistoricalRatesDataModel: Codable{
    var motd: MOTD?
    var success, timeseries: Bool?
    var base, startDate, endDate: String?
    var rates: [String: [String: Double]]?

    enum CodingKeys: String, CodingKey {
        case motd, success, timeseries, base
        case startDate = "start_date"
        case endDate = "end_date"
        case rates
    }
}
