//
//  ExchangeRateView.swift
//  ExchangeRate
//
//  Created by Arjun on 24/04/22.
//

import SwiftUI
import SwiftUICharts
struct ExchangeRateView: View {
    @Binding var currencyList:[String: Double]
    @Binding var currencyFrom:String
    @StateObject private var model = ExchangeRateViewModel()
    @State var showAnimationOnCurrencyDetail:Bool = false
    @State var currencyFromInput:Double = 0.1
    
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading) {
                
                if showAnimationOnCurrencyDetail {
                    VStack(alignment: .leading, spacing: 10) {

                        Text("1 \(self.model.exchangeRateValue?.query?.from ?? "") equals")
                            .font(.title)
                        
                        Text("\(self.model.exchangeRateValue?.info?.rate ?? 0) \(self.model.exchangeRateValue?.query?.to ?? "")" )
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text(self.model.exchangeRateValue?.date ?? "")
                            .foregroundColor(.gray)
                        
                    }.padding()
                        .transition(.opacity.combined(with: .slide))
                }
                
                VStack(alignment: .center) {
                    
                    Form {
                        Section(header: Text("Convert Currency")) {
                            
                            TextField("Enter an amount", value: self.$model.txtCurrencyFrom, format: .currency(code: self.currencyFrom))
                                .onChange(of: self.model.txtCurrencyFrom, perform: { newValue in
                                    
                                    if newValue == 0 {
                                        self.model.txtCurrencyTo = 0
                                        return
                                    }
                                    Task {
                                        await self.model.exchangeRates(from: self.currencyFrom, to: self.model.currencyTo, ammount: "\(newValue)")
                                    }
                                })
                                .keyboardType(.decimalPad)
                            
                            Picker(selection: self.$currencyFrom) {
                                
                                ForEach(self.currencyList.keys.sorted(), id: \.self) { key in
                                    
                                    HStack {
                                        Text(HelperManager.getFlag(from: key )).font(.title)
                                        Text(key).fontWeight(.semibold)
                                    }
                                    
                                }
                            } label: {
                                Text("From")
                            }
                            
                            Picker(selection: self.$model.currencyTo) {
                                
                                ForEach(self.currencyList.keys.sorted(), id: \.self) { key in
                                    
                                    HStack {
                                        Text(HelperManager.getFlag(from: key )).font(.title)
                                        Text(key).fontWeight(.semibold)
                                    }
                                }
                            } label: {
                                Text("To")
                            }
                        }
                        
                        Section(header: Text("Conversion")) {
                            
                            
                            
                            Text(self.model.txtCurrencyTo, format: .currency(code: self.model.currencyTo))
                        }
                    }.animation(.default, value: showAnimationOnCurrencyDetail)
                    
                }.frame(height: 300, alignment: .center)
                
            }
            
        }.onAppear {
            
            self.model.txtCurrencyFrom =  1.0
            Task {
                await self.model.exchangeRates(from: self.currencyFrom, to: self.model.currencyTo, ammount: "1")
            }
            withAnimation(.easeInOut(duration: 0.36).delay(0.3)) {
                self.showAnimationOnCurrencyDetail = true
           }
        }
        
    }
}

struct ExchangeRateView_Previews: PreviewProvider {
    
    @State static var tempCurrency = ["AED": 4.167972,
                                      "AFN": 118.91123,
                                      "ALL": 121.353306,
                                      "AMD": 546.175542,
                                      "ANG": 2.035384,
                                      "AOA": 629.106987,
                                      "ARS": 116.624363,
                                      "AUD": 1.580224,
                                      "AWG": 2.042846,
                                      "AZN": 1.92923]
    
    static var previews: some View {
        ExchangeRateView(currencyList: $tempCurrency, currencyFrom: .constant("AED"))
    }
}
