//
//  WeatherHeaderView.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 24/06/2026.
//

import SwiftUI

struct WeatherHeaderView: View {
    let weatherData: WeatherData
    let textColor: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Text(weatherData.locationName)
                .font(.system(size: 34, weight: .medium))
                .foregroundColor(textColor)
            
            Text("\(Int(weatherData.currentTemp))°")
                .font(.system(size: 72, weight: .thin))
                .foregroundColor(textColor)
            
            HStack(spacing: 8) {
                Image(systemName: weatherData.conditionIconName)
                    .font(.title)
                
                Text(weatherData.conditionText)
                    .font(.title3)
                    .fontWeight(.medium)
            }
            .foregroundColor(textColor)
            
            Text("H: \(Int(weatherData.maxTempToday))°  L: \(Int(weatherData.minTempToday))°")
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(textColor)
        }
    }
}
