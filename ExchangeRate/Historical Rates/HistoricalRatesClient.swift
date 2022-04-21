//
//  HistoricalRatesClient.swift
//  ExchangeRate
//
//  Created by Arjun on 21/04/22.
//

import Foundation

class HistoricalratesClient {
    
    /// Retrive Last 52 week Historical data
    /// - Parameters:
    ///   - input: HistoricalRatesInputParameter
    ///   - response: HistoricalRatesDataModel
    func retriveHistoricalRates(input:HistoricalRatesInputParameter) async throws -> ResponseManager<HistoricalRatesDataModel> {
    
        let latestRatesAPI = String(format: APIConstant.getHistoricalRates , input.endDate, input.startDate, input.base, input.symbol)
        
        do {
            let request = try ClientManager.GET(latestRatesAPI)
            let (data,response) = try await URLSession.shared.data(for: request)

            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw ValidationError.invalidServerResponse }

            do {
                let session = try JSONDecoder().decode(HistoricalRatesDataModel.self, from: data)
                return ResponseManager.success(session)
            }catch {
                throw ValidationError.invalidResposeModel
            }
            
        }catch ValidationError.invalidUrl {
            throw ValidationError.invalidUrl
        }catch {
            throw ValidationError.invalidServerResponse
        }
    }
    
}
