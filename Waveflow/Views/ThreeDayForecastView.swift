//
//  ThreeDayForecastView.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 24/06/2026.
//

import SwiftUI

struct ThreeDayForecastView: View {
    let forecastDays: [ForecastDay]
    let backgroundImageName: String
    let textColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 6) {
                Image(systemName: "calendar")
                Text("3-DAY FORECAST")
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .foregroundColor(textColor.opacity(0.7))
            
            Divider()
                .background(textColor.opacity(0.3))
            
            ForEach(forecastDays) { day in
                NavigationLink(
                    destination: HourlyForecastView(
                        dayName: day.dayName,
                        hourlyForecasts: day.hourly,
                        backgroundImageName: backgroundImageName,
                        textColor: textColor
                    )
                ) {
                    ForecastDayRow(
                        dayName: day.dayName,
                        conditionIconName: day.conditionIconName,
                        minTemp: day.minTemp,
                        maxTemp: day.maxTemp
                    )
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding()
        .background(
            textColor == .black
            ? Color.white.opacity(0.2)
            : Color.black.opacity(0.3)
        )
        .cornerRadius(15)
        .padding(.horizontal)
    }
}
