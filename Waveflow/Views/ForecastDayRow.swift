//
//  ForecastDayRow.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 24/06/2026.
//

import SwiftUI

struct ForecastDayRow: View {
    let dayName: String
    let conditionIconName: String
    let minTemp: Double
    let maxTemp: Double
    
    var body: some View {
        HStack {
            Text(dayName)
                .frame(width: 120, alignment: .leading)
                .font(.body)
                .fontWeight(.medium)
            
            Spacer()
            
            Image(systemName: conditionIconName)
                .font(.title3)
            
            Spacer()
            
            Text("\(Int(minTemp))° - \(Int(maxTemp))°")
                .frame(width: 80, alignment: .trailing)
                .font(.body)
                .fontWeight(.medium)
        }
        .padding(.vertical, 4)
    }
}
