//
//  ClientManager.swift
//  ExchangeRate
//
//  Created by Arjun on 21/04/22.
//

import Foundation

enum ValidationError: Error {
    case invalidServerResponse
    case invalidResposeModel
    case invalidUrl
}

public enum ResponseManager<T> {
    case offline
    case success(T)
    case error(String)
}

extension URLRequest {
       mutating func addCommonHeaders() {
           self.setValue("application/json", forHTTPHeaderField: "Content-Type")
           self.setValue("application/json", forHTTPHeaderField: "Accept")
       }
}

final class ClientManager {
    
    private enum RequestType: String {
        case GET
        case POST
        case PUT
    }
    
    static func GET(_ url: String) throws -> URLRequest {
        
        if url.isEmpty {
            throw ValidationError.invalidUrl
        }
        
        let requestUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let serviceUrl = URL(string: requestUrl) else { throw ValidationError.invalidServerResponse }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = RequestType.GET.rawValue
        request.cachePolicy = .reloadIgnoringCacheData
        
        return request
    }

}
