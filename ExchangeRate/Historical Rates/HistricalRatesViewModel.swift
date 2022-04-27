//
//  HistricalRatesViewModel.swift
//  ExchangeRate
//
//  Created by Arjun on 21/04/22.
//

import Foundation

class HistoricalRatesOO: ObservableObject {
    
    private let client = HistoricalratesClient()
    @Published var ratesList = [String: [String: Double]]()
    @Published var rateHistoryInMonth = 1
    
    /// Get value from child dictionary
    /// - Parameter key: Parent dictionary key
    /// - Returns: Child dictionary value
    func getKeyValueOfRates(key:String) -> (String, Double) {
        
        var values:Double?
        let keyvalue = ratesList[key] ?? [String: Double]()
        
        for (_, value) in keyvalue {
            values = value
        }
        return (key, values ?? 0.0)
    }
    
    /// Return past date form current date
    /// - Parameter month: - Int
    /// - Returns: Date
    func getLastYearDate(month: Int) -> Date? {
        return Calendar.current.date(byAdding: .month, value: -month, to: Date())
    }
    
    
    /// Retrive Historical Rates
    @MainActor
    /// Get historical currency rate
    /// - Parameters:
    ///   - base: base currency
    ///   - symbol: symbol  currency
    func retriveHistoricalRates(base:String?, symbol:String?) async {
        
        let inputParameter = HistoricalRatesInputParameter(startDate: Date(), endDate: getLastYearDate(month: rateHistoryInMonth) ?? Date(), base: base ?? "USD", symbol: symbol ?? "")
        
        do {
            let response = try await self.client.retriveHistoricalRates(input: inputParameter)
            switch response {
            case let .success(rates):
                self.ratesList = rates.rates ?? [String: [String: Double]]()
            
            case let .error(error):
                debugPrint("====>\(error)")
            case .offline:
                debugPrint("Offline")
            }
        }catch {
            debugPrint(error.localizedDescription)
        }
       
    }
}
