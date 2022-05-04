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
    @State var showBaseCurrencyView:Bool = false
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .center, spacing: 0) {
                
                NavigationLink(destination: HistoricalRatesView(selectedCurrency: self.model.historicalRatesRequest, favouriteRateList: $model.favouriteRateList), isActive: $showHistoricalRateView,
                               label: { })
                
                List {
                    
                    if self.model.favouriteRateList.count > 0 {
                        
                        Section("Favourite List") {
                            
                            ForEach(Array(self.model.favouriteRateList), id: \.self) { rateValue in
                                
                                let rate = model.getValueFromDictionary(input: rateValue)
                                
                                LatestRateCellView(title: rate.0, value: rate.1)
                                    .contentShape(RoundedRectangle(cornerRadius: 0))
                                    .onTapGesture {
                                        
                                        self.model.setHistoricalRatesRequest(base: self.model.latestRates.base ?? defaultBaseCurrency, symbol: rate.0, symbolValue: rate.1)
                                        
                                        self.showHistoricalRateView.toggle()
                                        
                                    }
                            }
                        }
                    }
                    
                    Section("Live Rate") {
                        
                        ForEach(model.ratesList.keys.sorted(), id: \.self) { key in
                            
                            LatestRateCellView(title: key, value: model.ratesList[key])
                                .contentShape(RoundedRectangle(cornerRadius: 0))
                                .onTapGesture {
                                    
                                    self.model.setHistoricalRatesRequest(base: self.model.latestRates.base ?? defaultBaseCurrency, symbol: key, symbolValue: (model.ratesList[key] ?? 0.0))
                                    
                                    self.showHistoricalRateView.toggle()
                                }
                            
                        }
                    }
                    
                }.listStyle(.grouped)
                    .refreshable {
                        Task {
                            await self.model.retriveLatestRatesSync(base: defaultBaseCurrency)
                        }
                    }
                
            }.onAppear {
                Task {
                    await self.model.retriveLatestRatesSync(base: defaultBaseCurrency)
                }
            }.navigationTitle("Latest Rates")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    Button {
                        showBaseCurrencyView.toggle()
                    } label: {
                        
                        VStack(alignment: .center, spacing: 5) {
                            
                            HStack(alignment: .center, spacing: 5) {
                                Text(self.model.latestRates.base ?? "USD")
                                    .font(.system(size: 20, weight: .bold))
                                Image(systemName: "chevron.down")
                            }
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ExchangeRateView(currencyList: (self.$model.latestRates.rates), currencyFrom: self.$defaultBaseCurrency)) {
                        Image(systemName: "arrow.left.arrow.right")
                    }
                    
                }
            }
            .sheet(isPresented: $showBaseCurrencyView) {
                
                BaseCurrencyView(latestRates: self.$model.latestRates, defaultBaseCurrency: $defaultBaseCurrency)
                    .onDisappear {
                        Task {
                            await self.model.retriveLatestRatesSync(base: defaultBaseCurrency)
                        }
                    }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct LiveRateView_Previews: PreviewProvider {
    static var previews: some View {
        LiveRateView()
    }
}
