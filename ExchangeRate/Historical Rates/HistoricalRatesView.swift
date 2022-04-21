//
//  HistoricalRatesView.swift
//  ExchangeRate
//
//  Created by Arjun on 21/04/22.
//

import SwiftUI

struct HistoricalRatesView: View {
    
    var selectedCurrency:LiveRateViewRequestDataModel?
    @StateObject private var model = HistoricalRatesOO()
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 10) {
            
            List {
                
                Section("Historical Rates") {
                    ForEach(model.ratesList?.keys.sorted().reversed() ?? [String:[String: Double]]().keys.sorted(), id: \.self) { key in
                        
                        let rateValue = self.model.getKeyValueOfRates(key: key)
                        
                        
                        HStack(alignment: .center, content: {
                            
                            Text(rateValue.0).fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(String(format: "%.4f", rateValue.1 ))
                            
                            Image(systemName: "chevron.right")
                                .padding(.horizontal, 10)
                            
                        })

                    }
                }
            }.listStyle(.grouped)
            
        }.onAppear {
            Task {
                await self.model.retriveHistoricalRates(base: selectedCurrency?.base ?? "" , symbol: selectedCurrency?.symbol ?? "")
            }
        }
    }
}

struct HistoricalRatesView_Previews: PreviewProvider {
    
    static let selectedCurrency = LiveRateViewRequestDataModel(base: "USD", symbol: "INR", symbolValue: 0.0)
    
    
    static var previews: some View {
        HistoricalRatesView(selectedCurrency: selectedCurrency)
    }
}
