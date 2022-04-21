//
//  LiveRateView.swift
//  ExchangeRate
//
//  Created by Arjun on 21/04/22.
//

import SwiftUI

struct LiveRateView: View {
    @StateObject var model = LiveRateViewModel()
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            List {
                
                Section("Live Rate") {
                    
                    ForEach(model.ratesList.keys.sorted(), id: \.self) { key in
                        
                        HStack(alignment: .center, content: {
                            
                            Text(key).fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(String(format: "%.4f", model.ratesList[key] ?? 0.0))
                            
                            Image(systemName: "chevron.right")
                                .padding(.horizontal, 10)
                            
                        })
                       
                    
                    }
                }
                
            }.listStyle(.grouped)
                .onAppear {
                    Task {
                        await self.model.retriveLatestRatesSync(base: "USD")
                    }
                }
            
        }
    }
}

struct LiveRateView_Previews: PreviewProvider {
    static var previews: some View {
        LiveRateView()
    }
}
