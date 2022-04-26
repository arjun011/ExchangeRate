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
    @Published var txtCurrencyFrom:String = ""
    @Published var txtCurrencyTo:String = ""
    @Published var currencyFrom:String = "NOK"
    @Published var currencyTo:String = "AMD"
    
     var observerTxtCurrencyFrom:Bool = true
     var observerTxtCurrencyTo:Bool = true
    

    
    /// Retrive latest currency rate
    /// - Parameter base: base currency
    @MainActor
    func exchangeRates(from currencyFrom: String, to currencyTo:String, ammount:String, isUpdateFrom: Bool) async {
        
        do {
            let response = try await self.client.exchangeRates(from: currencyFrom, to: currencyTo, ammount: ammount)
            switch response {
            case let .success(rates):
               
           
                
                self.exchangeRateValue = rates
                
                if isUpdateFrom {
                    self.txtCurrencyFrom = "\(self.exchangeRateValue?.result ?? 0)"
                }else {
                    self.txtCurrencyTo = "\(self.exchangeRateValue?.result ?? 0)"
                }
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    
                    self.observerTxtCurrencyFrom = true
                    self.observerTxtCurrencyTo = true
                }
                print("Update observer")
         
              
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
