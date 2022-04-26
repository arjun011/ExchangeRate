//
//  ExchangeRateView.swift
//  ExchangeRate
//
//  Created by Arjun on 24/04/22.
//

import SwiftUI

struct ExchangeRateView: View {
    var baseCurrency:String
    @Binding var currencyList:[String: Double]
    @StateObject var model = ExchangeRateViewModel()
    
    var body: some View {
        
        VStack(alignment: .center) {
        
            Spacer()
            
            VStack(alignment: .center) {

                HStack(alignment: .center) {
                                        
                    TextField("1", text: self.$model.txtCurrencyFrom)
                        .onChange(of: self.model.observerTxtCurrencyFrom ? self.model.txtCurrencyFrom : "", perform: { newValue in

                            print("Currency From",newValue)

                            self.model.observerTxtCurrencyTo = false

                            Task {
                                await self.model.exchangeRates(from: self.model.currencyFrom, to: self.model.currencyTo, ammount: newValue, isUpdateFrom: false)
                            }
                        })
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                        
                    
                    Spacer()
                    
                    Picker(selection: self.$model.currencyFrom) {
                        
                        ForEach(self.currencyList.keys.sorted(), id: \.self) { key in

                            Text(key)
                        }
                    } label: {
                        
                        Text(self.model.currencyFrom)
                    }

                    
                }.padding()
                
                HStack(alignment: .center) {
                    
                    TextField("1", text: self.$model.txtCurrencyTo)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                        .onChange(of: self.model.observerTxtCurrencyTo ? self.model.txtCurrencyTo : "", perform: { newValue in
                            
                            print("Currency To",newValue)
                            
                            self.model.observerTxtCurrencyFrom = false

                            print("API CAlled Update UI")

                            Task {
                                await self.model.exchangeRates(from: self.model.currencyTo, to: self.model.currencyFrom, ammount: newValue, isUpdateFrom: true)
                            }
                            
                        })
                    
                    Spacer()
                    
                    Picker(selection: self.$model.currencyTo) {
                        
                        ForEach(self.currencyList.keys.sorted(), id: \.self) { key in
                            
                            Text(key)
                        }
                    } label: {
                        
                        Text(self.model.currencyTo)
                    }
                    
                    
                }.padding()
                
            }.background(.ultraThickMaterial)
            .padding()
            Spacer()
            
        }.onAppear {
            self.model.currencyFrom = self.baseCurrency
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
                                     "AZN": 1.92923,
                                     "BAM": 1.95468,
                                     "BBD": 2.26981,
                                     "BDT": 97.024176,
                                     "BGN": 1.956957,
                                     "BHD": 0.428175,
                                     "BIF": 2257.462616,
                                     "BMD": 1.134504,
                                     "BND": 1.534691,
                                     "BOB": 7.773946,
                                     "BRL": 6.394753,
                                     "BSD": 1.134916,
                                     "BTC": 0.000027,
                                     "BTN": 83.896824,
                                     "BWP": 13.167125,
                                     "BYN": 2.923555,
                                     "BZD": 2.275872,
                                     "CAD": 1.43548,
                                     "CDF": 2267.574646,
                                     "CHF": 1.042792,
                                     "CLF": 0.034225,
                                     "CLP": 941.616881,
                                     "CNH": 7.241721,
                                     "CNY": 7.236723,
                                     "COP": 4557.975201,
                                     "CRC": 725.044091,
                                     "CUC": 1.134918,
                                     "CUP": 29.21611,
                                     "CVE": 110.625693,
                                     "CZK": 24.482429,
                                     "DJF": 201.13679,
                                     "DKK": 7.434868,
                                     "DOP": 64.901656,
                                     "DZD": 158.280482,
                                     "EGP": 17.843938,
                                     "ERN": 17.020453,
                                     "ETB": 55.999814,
                                     "EUR": 1,
                                     "FJD": 2.42404,
                                     "FKP": 0.835406,
                                     "GBP": 0.835125,
                                     "GEL": 3.511961,
                                     "GGP": 0.834768,
                                     "GHS": 6.985239,
                                     "GIP": 0.835308,
                                     "GMD": 59.908167,
                                     "GNF": 10310.325511,
                                     "GTQ": 8.717436,
                                     "GYD": 236.218513,
                                     "HKD": 8.848006,
                                     "HNL": 27.729492,
                                     "HRK": 7.512075,
                                     "HTG": 112.879664,
                                     "HUF": 358.641436,
                                     "IDR": 16275.841054,
                                     "ILS": 3.533915,
                                     "IMP": 0.834777,
                                     "INR": 84.252624,
                                     "IQD": 1649.604793,
                                     "IRR": 47937.568235,
                                     "ISK": 145.82329,
                                     "JEP": 0.835189,
                                     "JMD": 174.364535,
                                     "JOD": 0.805272,
                                     "JPY": 131.218037,
                                     "KES": 128.036507,
                                     "KGS": 96.217604,
                                     "KHR": 4605.389136,
                                     "KMF": 491.857347,
                                     "KPW": 1021.155366,
                                     "KRW": 1358.860035,
                                     "KWD": 0.344389,
                                     "KYD": 0.940791,
                                     "KZT": 491.643437,
                                     "LAK": 12716.408742,
                                     "LBP": 1709.471314,
                                     "LKR": 229.055318,
                                     "LRD": 166.931518,
                                     "LSL": 17.691203,
                                     "LYD": 5.197975,
                                     "MAD": 10.488441,
                                     "MDL": 20.255297,
                                     "MGA": 4490.077245,
                                     "MKD": 61.539878,
                                     "MMK": 2007.438252,
                                     "MNT": 3245.768352,
                                     "MOP": 9.070968,
                                     "MRU": 41.206654,
                                     "MUR": 49.586305,
                                     "MVR": 17.530481,
                                     "MWK": 922.912667,
                                     "MXN": 23.13343,
                                     "MYR": 4.776445,
                                     "MZN": 72.436403,
                                     "NAD": 17.740199,
                                     "NGN": 466.297669,
                                     "NIO": 40.087681,
                                     "NOK": 10.032973,
                                     "NPR": 134.234345,
                                     "NZD": 1.675945,
                                     "OMR": 0.43711,
                                     "PAB": 1.13529,
                                     "PEN": 4.483399,
                                     "PGK": 3.974516,
                                     "PHP": 58.23784,
                                     "PKR": 199.676707,
                                     "PLN": 4.543837,
                                     "PYG": 7851.52161,
                                     "QAR": 4.128111,
                                     "RON": 4.942597,
                                     "RSD": 117.434489,
                                     "RUB": 85.713452,
                                     "RWF": 1167.794699]
    
    static var previews: some View {
        ExchangeRateView(baseCurrency: "ALL", currencyList: $tempCurrency)
    }
}
