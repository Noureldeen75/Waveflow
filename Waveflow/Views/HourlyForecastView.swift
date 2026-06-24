//
//  HourlyForecastView.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 21/06/2026.
//

import SwiftUI

struct HourlyForecastView: View {
    let dayName: String
    let hourlyForecasts: [HourlyForecast]
    let backgroundImageName: String
    let textColor: Color
    
    var body: some View {
        ZStack {
            Image(backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                List(hourlyForecasts) { hour in
                    HourlyForecastRow(
                        hour: hour,
                        textColor: textColor
                    )
                    .padding(.vertical, 8)
                    .listRowBackground(Color.clear)
                }
                .listStyle(PlainListStyle())
                .background(Color.clear)
            }
        }
        .navigationTitle("\(dayName) Forecast")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    HourlyForecastView(
        dayName: "Today",
        hourlyForecasts: [
            HourlyForecast(
                time: "Now",
                conditionIconName: "sun.max.fill",
                temp: 25
            ),
            HourlyForecast(
                time: "6 PM",
                conditionIconName: "cloud.sun.fill",
                temp: 23
            )
        ],
        backgroundImageName: "morning",
        textColor: .black
    )
}
