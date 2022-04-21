//
//  HistoricalRatesView.swift
//  ExchangeRate
//
//  Created by Arjun on 21/04/22.
//

import SwiftUI
import StockCharts
struct HistoricalRatesView: View {
    
    var selectedCurrency:LiveRateViewRequestDataModel?
    @StateObject private var model = HistoricalRatesOO()
    @Environment(\.presentationMode) var presentationMode
    @State var isFavourite:Bool = false
    @Binding var favouriteRateList:Set<[String:Double]>
    
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
                
                Button {
                    self.isFavourite.toggle()
                    if self.isFavourite {
                        self.favouriteRateList.insert([selectedCurrency?.symbol ?? "":selectedCurrency?.symbolValue ?? 00])
                    }else {
                        self.favouriteRateList.remove([selectedCurrency?.symbol ?? "":selectedCurrency?.symbolValue ?? 00])
                    }
                } label: {
                    Image(systemName: isFavourite ? "star.fill" : "star")
                    
                }.font(.system(size: 25, weight: .medium))
                
                
            }.padding(.horizontal)
            
            VStack(alignment: .center) {
                
                Picker("What is your favorite color?", selection: self.$model.favoriteColor) {
                                Text("1M").tag(1)
                                Text("6M").tag(6)
                                Text("1Y").tag(12)
                            }
                            .pickerStyle(.segmented)
                            .onChange(of: self.model.favoriteColor) { tag in
                            
                                Task {
                                    await self.model.retriveHistoricalRates(base: selectedCurrency?.base ?? "" , symbol: selectedCurrency?.symbol ?? "")
                                }
                                
                            }
                
                LineChartView(
                    lineChartController:
                        LineChartController(prices: self.model.currencyRateList, dates: self.model.currencyRateDateList, labelColor: Color.blue, indicatorPointColor: Color.blue, showingIndicatorLineColor: Color.green, flatTrendLineColor: Color.green, uptrendLineColor: Color.green, downtrendLineColor: Color.green, dragGesture: true)
                ).frame(maxWidth: .infinity, alignment: .center)
                .aspectRatio(2, contentMode: .fit)
                
                
            }.padding()

            List {
                
                Section("Historical Rates") {
                    ForEach(model.ratesList.keys.sorted().reversed() , id: \.self) { key in
                        
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
            
            if favouriteRateList.firstIndex(of: [selectedCurrency?.symbol ?? "":selectedCurrency?.symbolValue ?? 00]) != nil {
                self.isFavourite = true
            }
            
        }
    }
}

struct HistoricalRatesView_Previews: PreviewProvider {
    
    static let selectedCurrency = LiveRateViewRequestDataModel(base: "USD", symbol: "INR", symbolValue: 0.0)
    
    
    static var previews: some View {
        HistoricalRatesView(selectedCurrency: selectedCurrency, favouriteRateList: .constant(Set<[String:Double]>()))
    }
}
