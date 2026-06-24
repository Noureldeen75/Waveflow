//
//  WeatherDetailGridView.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 24/06/2026.
//

import SwiftUI

struct WeatherDetailGridView: View {
    let weatherData: WeatherData
    let textColor: Color
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                WeatherDetailCard(
                    title: "Visibility",
                    value: weatherData.visibility,
                    iconName: "eye.fill",
                    textColor: textColor
                )
                WeatherDetailCard(
                    title: "Humidity",
                    value: weatherData.humidity,
                    iconName: "humidity.fill",
                    textColor: textColor
                )
            }
            
            HStack(spacing: 12) {
                WeatherDetailCard(
                    title: "Feels Like",
                    value: weatherData.feelsLike,
                    iconName: "thermometer.medium",
                    textColor: textColor
                )
                WeatherDetailCard(
                    title: "Pressure",
                    value: weatherData.pressure,
                    iconName: "gauge.with.needle",
                    textColor: textColor
                )
            }
        }
        .padding(.horizontal)
    }
}
