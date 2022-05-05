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
    @Published var lineChartData = (rates: [Double](), dates: [String]())
    @Published var rateHistoryInMonth = 1
    @Published var historicalData:HistoricalRatesDataModel?

    func getDataLineChartData() {
        
        var currencyRateList = [Double]()
        var currencyRateDateList = [String]()
    
        let dateKeys: [String] = self.ratesList.map({ $0.key }).sorted()
        for key in dateKeys {
            let rateValue = self.getKeyValueOfRates(key: key)
            currencyRateList.append(rateValue.1)
            currencyRateDateList.append(rateValue.0)
        }
        
        self.lineChartData = (currencyRateList, currencyRateDateList)
        
    }
    
 
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
    
    /// Retrive value from dictionary
    /// - Parameter input: [String:Double]
    /// - Returns: (String,Double)
    func getValueFromDictionary(input:[String:Double]) -> (String,Double) {
        
        var keyResult:String = ""
        var valueResult:Double = 0.0
        
        for (key, value) in input {
            keyResult = key
            valueResult = value
        }
        
        return(keyResult,valueResult)
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
                self.getDataLineChartData()
                self.historicalData = rates
                
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
