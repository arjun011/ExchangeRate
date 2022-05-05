//
//  CountryPickerCellView.swift
//  ExchangeRate
//
//  Created by Arjun on 05/05/22.
//

import SwiftUI

struct CountryPickerCellView: View {
    var countryCode:String
    var body: some View {
        HStack {
            Text(HelperManager.getFlag(from: countryCode )).font(.title)
            Text(countryCode).fontWeight(.semibold)
        }
    }
}

struct CountryPickerCellView_Previews: PreviewProvider {
    static var previews: some View {
        CountryPickerCellView(countryCode: "INR")
    }
}
