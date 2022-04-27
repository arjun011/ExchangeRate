//
//  LiveRateClient.swift
//  ExchangeRate
//
//  Created by Arjun on 21/04/22.
//

import Foundation

class LiveRatesClient {
    
    /// Retrieve Latest currency rates
    /// - Parameters:
    ///   - base: base (Default USD)
    ///   - response: LatestRatesDataModel
    func retriveLatestRatesSync(base: String?) async throws -> ResponseManager<LatestRatesDataModel> {
      
        let latestRatesAPI = APIConstant.getLatestRates + "?base=\(base ?? "USD")"
        debugPrint(latestRatesAPI)
        
        do {
            let request = try ClientManager.GET(latestRatesAPI)
            let (data,response) = try await URLSession.shared.data(for: request)

            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw ValidationError.invalidServerResponse }

            let session = try JSONDecoder().decode(LatestRatesDataModel.self, from: data)

            return ResponseManager.success(session)
        }catch {
            throw ValidationError.invalidServerResponse
        }
    }
}
