//
//  APIManager.swift
//  ExchangeRate
//
//  Created by Arjun on 21/04/22.
//

import Foundation

fileprivate let baseUrl = "https://api.exchangerate.host/"

struct APIConstant {

    static let getLatestRates = baseUrl + "latest"
    
    static let getHistoricalRates = baseUrl + "timeseries?start_date=%@&end_date=%@&base=%@&symbols=%@"
    
    static let exchangeRate = baseUrl + "convert?from=%@&to=%@&amount=%@"
    

}
