//
//  LiveRateView.swift
//  ExchangeRate
//
//  Created by Arjun on 21/04/22.
//

import SwiftUI

struct LiveRateView: View {
    @StateObject var model = LiveRateViewModel()
    @State var showHistoricalRateView:Bool = false
    @State var defaultBaseCurrency:String = "USD"
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .center, spacing: 0) {
                
                NavigationLink(destination: HistoricalRatesView(selectedCurrency: self.model.historicalRatesRequest), isActive: $showHistoricalRateView,
                               label: { })
                
                List {
                    
                    Section("Live Rate") {
                        
                        ForEach(model.ratesList.keys.sorted(), id: \.self) { key in
                            
                            RateCellView(title: key, value: model.ratesList[key], isDetail: true)
                                .contentShape(RoundedRectangle(cornerRadius: 0))
                                .onTapGesture {
                                    
                                    self.model.setHistoricalRatesRequest(base: self.model.latestRates.base ?? defaultBaseCurrency, symbol: key, symbolValue: (model.ratesList[key] ?? 0.0))
                                    
                                    self.showHistoricalRateView.toggle()
                                }
                        
                        }
                    }
                    
                }.listStyle(.grouped)
                    .onAppear {
                        Task {
                            await self.model.retriveLatestRatesSync(base: "USD")
                        }
                    }
            }
            .navigationTitle("Latest Rates")
        }
    }
}

struct LiveRateView_Previews: PreviewProvider {
    static var previews: some View {
        LiveRateView()
    }
}
