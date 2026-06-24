//
//  SavedLocationRow.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 24/06/2026.
//

import SwiftUI

struct SavedLocationRow: View {
    let location: WeatherData
    let textColor: Color
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(location.locationName)
                    .font(.headline)
                    .foregroundColor(textColor)
                Text(location.conditionText)
                    .font(.subheadline)
                    .foregroundColor(textColor.opacity(0.7))
            }
            
            Spacer()
            
            Text("\(Int(location.currentTemp))°")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(textColor)
        }
    }
}
