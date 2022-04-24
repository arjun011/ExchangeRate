//
//  ExchangeRateView.swift
//  ExchangeRate
//
//  Created by Arjun on 24/04/22.
//

import SwiftUI

struct ExchangeRateView: View {
    @State var currencyFrist:String = ""
    @State var currencySecond:String = ""
    
    var body: some View {
        
        VStack(alignment: .center) {
        
            Spacer()
            
            VStack(alignment: .center) {
                
                HStack(alignment: .center) {
                    TextField("1", text: $currencyFrist)
                        .keyboardType(.asciiCapableNumberPad)
                    
                    Spacer()
                    
                    Text("USD")
                    
                }.padding()
                
                HStack(alignment: .center) {
                    TextField("1", text: $currencyFrist)
                        .keyboardType(.numberPad)
                    
                        
                    
                    Spacer()
        
                    
                    Text("INR")
                    
                }.padding()
                
            }.background(.ultraThickMaterial)
            .padding()
            Spacer()
            
        }
        
    }
}

struct ExchangeRateView_Previews: PreviewProvider {
    static var previews: some View {
        ExchangeRateView()
    }
}
