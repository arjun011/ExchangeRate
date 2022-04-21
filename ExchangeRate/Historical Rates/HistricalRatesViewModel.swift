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
    
    @Published var currencyRateList = [Double]()
    @Published var currencyRateDateList = [String]()
    @Published var favoriteColor = 1
    
    func getKeyValueOfRates(key:String) -> (String, Double) {
        
        var values:Double?
        let keyvalue = ratesList[key] ?? [String: Double]()
        
        for (_, value) in keyvalue {
            values = value
        }
        return (key, values ?? 0.0)
    }
    
    
    func getDataLineChartData() {
        
        self.currencyRateList = [Double]()
        self.currencyRateDateList = [String]()
    
        let dateKeys: [String] = self.ratesList.map({ $0.key }).sorted()
        for key in dateKeys {
            let rateValue = self.getKeyValueOfRates(key: key)
            self.currencyRateList.append(rateValue.1)
            self.currencyRateDateList.append(rateValue.0)
        }
        
    }
    
    private func getLastYearDate(month: Int) -> Date? {
        return Calendar.current.date(byAdding: .month, value: -month, to: Date())
    }
    
    
    /// Retrive Historical Rates
    @MainActor
    func retriveHistoricalRates(base:String?, symbol:String?) async {
        
        let inputParameter = HistoricalRatesInputParameter(startDate: Date(), endDate: getLastYearDate(month: favoriteColor) ?? Date(), base: base ?? "USD", symbol: symbol ?? "")
        
        do {
            let response = try await self.client.retriveHistoricalRates(input: inputParameter)
            switch response {
            case let .success(rates):
                self.ratesList = rates.rates ?? [String: [String: Double]]()
                self.getDataLineChartData()
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
