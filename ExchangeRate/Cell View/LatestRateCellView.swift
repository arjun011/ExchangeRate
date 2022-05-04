//
//  LatestRateCellView.swift
//  ExchangeRate
//
//  Created by Arjun on 05/05/22.
//

import SwiftUI

struct LatestRateCellView: View {
    
    var title:String?
    var value:Double?
    
    var body: some View {
        HStack {
            
            Text(HelperManager.getFlag(from: title ?? "")).font(.title)
            Text(self.title ?? "").fontWeight(.semibold)
            Spacer()
            Text(String(format: "%.4f", self.value ?? 0.0))
            
            Image(systemName: "chevron.right")
                        .padding(.horizontal, 10)
            
        }
    }
}

struct LatestRateCellView_Previews: PreviewProvider {
    static var previews: some View {
        LatestRateCellView()
    }
}
