//
//  HistocalRatesInputParameter.swift
//  ExchangeRate
//
//  Created by Arjun on 21/04/22.
//

import Foundation

struct HistoricalRatesInputParameter {
    
    var startDate:String
    var endDate:String
    var base:String
    var symbol:String
    
    static func convertDatetoString(date:Date) -> String {
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "YYYY-MM-dd"
        print(formatter3.string(from: date))
        return formatter3.string(from: date)
    }
    
    internal init(startDate: Date, endDate: Date, base: String, symbol: String) {
        self.startDate = HistoricalRatesInputParameter.convertDatetoString(date: Date())
        self.endDate = HistoricalRatesInputParameter.convertDatetoString(date: endDate)
        self.base = base
        self.symbol = symbol
    }

    
}
