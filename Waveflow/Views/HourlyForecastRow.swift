//
//  HourlyForecastRow.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 24/06/2026.
//

import SwiftUI

struct HourlyForecastRow: View {
    let hour: HourlyForecast
    let textColor: Color
    
    var body: some View {
        HStack {
            Text(hour.time)
                .font(.headline)
                .foregroundColor(textColor)
            
            Spacer()
            
            Image(systemName: hour.conditionIconName)
                .font(.title2)
                .foregroundColor(textColor)
            
            Spacer()
            
            Text("\(Int(hour.temp))°")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(textColor)
        }
    }
}
