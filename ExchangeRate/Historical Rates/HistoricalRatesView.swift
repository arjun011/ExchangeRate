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
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 10) {
            
            HStack(alignment: .center) {
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                }
                
                Spacer()
                VStack {
                    HStack(alignment: .center, spacing: 2, content: {
                        Text(selectedCurrency?.base ?? "")
                        Image(systemName: "circle.fill")
                            .font(.system(size: 10, weight: .regular))
                        Text(selectedCurrency?.symbol ?? "")
                    }).font(.system(size: 20, weight: .medium))
                }
                
                Spacer()
                
                
            }.padding(.horizontal)

            List {
                
                Section("Historical Rates") {
                    ForEach(model.ratesList?.keys.sorted().reversed() ?? [String:[String: Double]]().keys.sorted(), id: \.self) { key in
                        
                        
                        let rateValue = self.model.getKeyValueOfRates(key: key)

                        RateCellView(title: rateValue.0, value: rateValue.1)

                    }
                }
            }.listStyle(.grouped)
            .navigationBarHidden(true)
            
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
