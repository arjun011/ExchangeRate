//
//  BaseCurrencyView.swift
//  ExchangeRate
//
//  Created by Arjun on 24/04/22.
//

import SwiftUI

struct BaseCurrencyView: View {
    
    @Binding var latestRates:LatestRatesDataModel
    @Binding var defaultBaseCurrency:String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .center) {
            
            List {
                
                Section("Base Currency") {
                    
                    ForEach((latestRates.rates).keys.sorted(), id: \.self) { key in
                        
                        HStack(alignment: .center) {
                            CountryPickerCellView(countryCode: key)
                            Spacer()
                        }.contentShape(RoundedRectangle(cornerRadius: 0))
                            .onTapGesture {
                                defaultBaseCurrency = key
                                self.presentationMode.wrappedValue.dismiss()
                            }
                    }
                }
            }
        }
    }
}

//struct BaseCurrencyView_Previews: PreviewProvider {
//    static var previews: some View {
//        BaseCurrencyView()
//    }
//}
