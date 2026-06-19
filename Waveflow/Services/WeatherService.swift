//
//  WeatherService.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 19/06/2026.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchWeatherData() -> WeatherData
}

class MockWeatherService: WeatherServiceProtocol {
    func fetchWeatherData() -> WeatherData {
        let forecastDays = [
            ForecastDay(dayName: "Today", conditionIconName: "sun.max.fill", minTemp: 20, maxTemp: 30),
            ForecastDay(dayName: "Tomorrow", conditionIconName: "cloud.sun.fill", minTemp: 18, maxTemp: 28),
            ForecastDay(dayName: "After Tomorrow", conditionIconName: "cloud.fill", minTemp: 17, maxTemp: 26)
        ]
        
        return WeatherData(
            locationName: "Cairo",
            currentTemp: 25,
            conditionText: "Sunny",
            conditionIconName: "sun.max.fill",
            maxTempToday: 30,
            minTempToday: 20,
            forecast: forecastDays,
            visibility: "10 km",
            humidity: "60%",
            feelsLike: "27°C",
            pressure: "1012 hPa"
        )
    }
}
