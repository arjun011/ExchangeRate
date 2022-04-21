//
//  HistricalRatesViewModel.swift
//  ExchangeRate
//
//  Created by Arjun on 21/04/22.
//

import Foundation

class HistoricalRatesOO: ObservableObject {
    
    private let client = HistoricalratesClient()
    @Published var ratesList:[String: [String: Double]]?
    
    func getKeyValueOfRates(key:String) -> (String, Double) {
        
        var values:Double?
        let keyvalue = ratesList?[key] ?? [String: Double]()
        
        for (_, value) in keyvalue {
            values = value
        }
        return (key, values ?? 0.0)
    }
    
    private func getLastYearDate() -> Date? {
        let today = Date()
        let nextDate = Calendar.current.date(byAdding: .day, value: -364, to: today)
        return nextDate
    }
    
    
    /// Retrive Historical Rates
    @MainActor
    func retriveHistoricalRates(base:String?, symbol:String?) async {
        
        let inputParameter = HistoricalRatesInputParameter(startDate: Date(), endDate: getLastYearDate() ?? Date(), base: base ?? "USD", symbol: symbol ?? "")
        
        do {
            let response = try await self.client.retriveHistoricalRates(input: inputParameter)
            switch response {
            case let .success(rates):
                self.ratesList = rates.rates
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
