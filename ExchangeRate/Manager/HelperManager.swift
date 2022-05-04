//
//  HelperManager.swift
//  ExchangeRate
//
//  Created by Arjun on 05/05/22.
//

import Foundation

class HelperManager {
    
   static func getFlag(from countryCode: String) -> String {
       
       let code = countryCode.prefix(2)
       
      return code
            .unicodeScalars
            .map({ 127397 + $0.value })
            .compactMap(UnicodeScalar.init)
            .map(String.init)
            .joined()
    }
}
