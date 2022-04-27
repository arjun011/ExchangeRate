//
//  ExchangeRateClient.swift
//  ExchangeRate
//
//  Created by Arjun on 24/04/22.
//

import Foundation

class ExchangeRateClient {
    
    func exchangeRates(from fristCurrency: String, to SecondCurrency:String, ammount:String) async throws -> ResponseManager<ExchangeRateDataModel> {
      
        
        let latestRatesAPI = String(format: APIConstant.exchangeRate , fristCurrency, SecondCurrency, ammount)

        do {
            let request = try ClientManager.GET(latestRatesAPI)
            let (data,response) = try await URLSession.shared.data(for: request)

            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw ValidationError.invalidServerResponse }

            let session = try JSONDecoder().decode(ExchangeRateDataModel.self, from: data)

            return ResponseManager.success(session)
        }catch {
            
            print(error.localizedDescription)
            throw ValidationError.invalidServerResponse
        }
    }
}
