//
//  LiveRateViewModel.swift
//  ExchangeRate
//
//  Created by Arjun on 21/04/22.
//

import Foundation

class LiveRateViewModel: ObservableObject {
   
    
    @Published var latestRates:LatestRatesDataModel = LatestRatesDataModel()
    @Published var ratesList:[String: Double] = [String: Double]()
    
    private let client = LiveRatesClient()
    
    /// Retrive latest currency rate
    /// - Parameter base: base currency
    @MainActor
    func retriveLatestRatesSync(base:String?) async {
        
        do {
            let response = try await self.client.retriveLatestRatesSync(base: base)
            switch response {
            case let .success(rates):
                self.latestRates = rates
                
                self.ratesList = self.latestRates.rates ?? [String:Double]()
                
            case let .error(error):
                debugPrint("====>\(error)")
            case .offline:
                debugPrint("Offline")
            }
        }catch {
            debugPrint("Error")
        }
    }
    
}
