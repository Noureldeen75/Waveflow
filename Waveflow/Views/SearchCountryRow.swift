//
//  SearchCountryRow.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 24/06/2026.
//

import SwiftUI

struct SearchCountryRow: View {
    let countryName: String
    let textColor: Color
    
    var body: some View {
        HStack {
            Text(countryName)
                .font(.headline)
                .foregroundColor(textColor)
            Spacer()
            Image(systemName: "plus.circle.fill")
                .foregroundColor(textColor)
        }
    }
}
