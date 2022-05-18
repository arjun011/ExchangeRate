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
            
            VStack(alignment: .center) {
                
                Picker("", selection: self.$model.rateHistoryInMonth) {
                    Text("1M").tag(1)
                    Text("6M").tag(6)
                    Text("1Y").tag(12)
                }
                .pickerStyle(.segmented)
                .onChange(of: self.model.rateHistoryInMonth) { tag in
                    
                    Task {
                        await self.model.retriveHistoricalRates(base: selectedCurrency?.base ?? "" , symbol: selectedCurrency?.symbol ?? "")
                    }
                    
                }
                
                LineChartView(
                    lineChartController:
                        LineChartController(prices: self.model.lineChartData.rates, dates: self.model.lineChartData.dates, labelColor: Color.blue, indicatorPointColor: Color.blue, showingIndicatorLineColor: Color.green, flatTrendLineColor: Color.green, uptrendLineColor: Color.green, downtrendLineColor: Color.green, dragGesture: true)
                ).frame(maxWidth: .infinity, alignment: .center)
                    .aspectRatio(2, contentMode: .fit)
                
                
            }.padding()
            
            List {
                
                Section("Historical Rates") {
                    
                    ForEach(model.historicalData?.historyRate ?? [[String:Double]](), id: \.self) { value in
                        
                        let rate = self.model.getValueFromDictionary(input: value)
                        
                        RateCellView(title: rate.0, value: rate.1)
                    }
                }
            }.listStyle(.grouped)
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(Text(selectedCurrency?.base ?? "") + Text("*") +
                                  Text(selectedCurrency?.symbol ?? ""))
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.backward")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        Button {
                            self.isFavourite.toggle()
                            if self.isFavourite {
                                self.favouriteRateList.insert([selectedCurrency?.symbol ?? "":selectedCurrency?.symbolValue ?? 00])
                            }else {
                                self.favouriteRateList.remove([selectedCurrency?.symbol ?? "":selectedCurrency?.symbolValue ?? 00])
                            }
                        } label: {
                            Image(systemName: isFavourite ? "star.fill" : "star")
                            
                        }
                    }
                }
            
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
