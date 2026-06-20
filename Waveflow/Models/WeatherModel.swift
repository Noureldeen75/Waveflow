//
//  WeatherModel.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 19/06/2026.
//

import Foundation

struct WeatherData: Identifiable {
    let id = UUID()
    let locationName: String
    let currentTemp: Double
    let conditionText: String
    let conditionIconName: String
    let maxTempToday: Double
    let minTempToday: Double
    
    let forecast: [ForecastDay]
    
    let visibility: String
    let humidity: String
    let feelsLike: String
    let pressure: String
}

struct ForecastDay: Identifiable {
    let id = UUID()
    let dayName: String
    let conditionIconName: String
    let minTemp: Double
    let maxTemp: Double
    let hourly: [HourlyForecast]
}

struct HourlyForecast: Identifiable {
    let id = UUID()
    let time: String
    let conditionIconName: String
    let temp: Double
}
