//
//  RateCellView.swift
//  ExchangeRate
//
//  Created by Arjun on 21/04/22.
//

import SwiftUI

struct RateCellView: View {
    
    var title:String?
    var value:Double?
    var isDetail:Bool = false
    
    var body: some View {
        HStack {
            Text(self.title ?? "").fontWeight(.semibold)
            Spacer()
            Text(String(format: "%.4f", self.value ?? 0.0))
            
            if self.isDetail {
                Image(systemName: "chevron.right")
                        .padding(.horizontal, 10)
            }
        }
    }
}

struct RateCellView_Previews: PreviewProvider {
    static var previews: some View {
        RateCellView()
    }
}
