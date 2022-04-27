//
//  APIManager.swift
//  ExchangeRate
//
//  Created by Arjun on 21/04/22.
//

import Foundation

fileprivate let baseUrl = "https://api.exchangerate.host/"

struct APIConstant {
    
    /// Retirve latest rates
    static let getLatestRates = baseUrl + "latest"
    
    /// Retrive historical rates
    static let getHistoricalRates = baseUrl + "timeseries?start_date=%@&end_date=%@&base=%@&symbols=%@"
    
    /// Exchnage currency from one currency to other.
    static let exchangeRate = baseUrl + "convert?from=%@&to=%@&amount=%@"
    
}
