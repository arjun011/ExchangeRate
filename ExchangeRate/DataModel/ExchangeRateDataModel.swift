//
//  ExchangeRateDataModel.swift
//  ExchangeRate
//
//  Created by Arjun on 24/04/22.
//

import Foundation

// MARK: - Welcome
struct ExchangeRateDataModel: Codable {
    var motd: MOTD?
    var success: Bool?
    var query: Query?
    var info: Info?
    var historical: Bool?
    var date: String?
    var result: Double?
}

// MARK: - Info
struct Info: Codable {
    var rate: Double?
}

// MARK: - Query
struct Query: Codable {
    var from, to: String?
    var amount: Float?
}
