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
    var historyRate:[[String:Double]]? {
        get {
            var listArray = [[String:Double]]()
            
            for i in rates?.keys.sorted() ?? [String](){
                listArray.append(self.getKeyValueOfRates(key: i))
            }
            return listArray
        }
    }

    enum CodingKeys: String, CodingKey {
        case motd, success, timeseries, base
        case startDate = "start_date"
        case endDate = "end_date"
        case rates
    }
    
    
    //MARK: - Functions -
    
    /// Get value from child dictionary
    /// - Parameter key: Parent dictionary key
    /// - Returns: Child dictionary value
    func getKeyValueOfRates(key:String) -> [String:Double] {
        
        var values:Double = 0.0
        let keyvalue = self.rates?[key] ?? [String: Double]()
        
        for (_, value) in keyvalue {
            values = value
        }
        return [key:values]
    }
 
}
