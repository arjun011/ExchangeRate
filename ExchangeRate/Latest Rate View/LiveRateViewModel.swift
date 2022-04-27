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
    @Published var historicalRatesRequest:LiveRateViewRequestDataModel?
    @Published var favouriteRateList = Set<[String:Double]>()
    
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
                
                let updatedResult = self.updateFavouriteList(inputDict: self.latestRates.rates , favouriteListSet: self.favouriteRateList)
                
                self.favouriteRateList = updatedResult.updatedFavouriteListSet
                self.ratesList = updatedResult.updatedRatesDict
                
            case let .error(error):
                debugPrint("====>\(error)")
            case .offline:
                debugPrint("Offline")
            }
        }catch {
            debugPrint("Error")
        }
    }
    
    func setHistoricalRatesRequest(base: String?, symbol: String?, symbolValue: Double?){
        self.historicalRatesRequest = LiveRateViewRequestDataModel(base: base, symbol: symbol, symbolValue: symbolValue)
    }
    
    /// Update Favourite list
    /// - Parameters:
    ///   - inputDict: [String: Double]
    ///   - favouriteListSet: Set<[String:Double]>
    /// - Returns: (updatedRatesDict: [String: Double],updatedFavouriteListSet :Set<[String:Double]>)
    func updateFavouriteList(inputDict: [String: Double], favouriteListSet: Set<[String:Double]>) -> (updatedRatesDict: [String: Double],updatedFavouriteListSet :Set<[String:Double]>) {
        
        var mutableDict = inputDict
        var mutableFavouriteListSet = favouriteListSet
        
        for (key, value) in mutableDict {
            
            if let oldValue = mutableFavouriteListSet.firstIndex(where: { ($0[key] ?? 0) > 0.01}) {
                mutableFavouriteListSet.remove(at: oldValue)
                mutableFavouriteListSet.insert([key:value])
                mutableDict[key] = nil
            }
        }
        
        return (mutableDict, mutableFavouriteListSet)
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
    

}
