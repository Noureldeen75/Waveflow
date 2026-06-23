//
//  WeatherModel.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 19/06/2026.
//

import Foundation

struct APIWeatherResponse: Codable {
    let location: APILocation
    let current: APICurrent
    let forecast: APIForecast
}

struct APILocation: Codable {
    let name: String
    let region: String
    let country: String
}

struct APICurrent: Codable {
    let temp_c: Double
    let condition: APICondition
    let humidity: Int
    let feelslike_c: Double
    let vis_km: Double
    let pressure_mb: Double
}

struct APICondition: Codable {
    let text: String
    let icon: String
    let code: Int
}

struct APIForecast: Codable {
    let forecastday: [APIForecastDay]
}

struct APIForecastDay: Codable {
    let date: String
    let day: APIDayInfo
    let hour: [APIHour]
}

struct APIDayInfo: Codable {
    let maxtemp_c: Double
    let mintemp_c: Double
    let condition: APICondition
}

struct APIHour: Codable {
    let time: String
    let temp_c: Double
    let condition: APICondition
}

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

struct CountryEntry: Codable, Identifiable {
    var id: String { name }
    let name: String
    let query: String
}
