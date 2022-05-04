//
//  ExchangeRateViewModel.swift
//  ExchangeRate
//
//  Created by Arjun on 24/04/22.
//

import Foundation

class ExchangeRateViewModel: ObservableObject {
 
    
    private let client = ExchangeRateClient()
    @Published var exchangeRateValue:ExchangeRateDataModel?
    @Published var txtCurrencyFrom:Double = 1.0
    @Published var txtCurrencyTo:Double = 0
    @Published var currencyFrom:String = "NOK"
    @Published var currencyTo:String = "AMD"
    
    
    /// Retrive latest currency rate
    /// - Parameter base: base currency
    @MainActor
    func exchangeRates(from currencyFrom: String, to currencyTo:String, ammount:String) async {
        
        do {
            let response = try await self.client.exchangeRates(from: currencyFrom, to: currencyTo, ammount: ammount)
            switch response {
            case let .success(rates):
               
                self.exchangeRateValue = rates
                self.txtCurrencyTo = self.exchangeRateValue?.result ?? 0
                
            case let .error(error):
                debugPrint("====>\(error)")
            case .offline:
                debugPrint("Offline")
            }
        }catch {
            
            debugPrint(error)
            debugPrint("Error")
        }
    }
    
}
