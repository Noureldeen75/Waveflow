//
//  WeatherService.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 19/06/2026.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchWeatherData(for locationName: String) -> WeatherData
    func fetchDefaultLocations() -> [WeatherData]
}

class MockWeatherService: WeatherServiceProtocol {
    func fetchWeatherData(for locationName: String) -> WeatherData {
        let hourlyToday = [
            HourlyForecast(
                time: "Now",
                conditionIconName: "sun.max.fill",
                temp: 25
            ),
            HourlyForecast(
                time: "6 PM",
                conditionIconName: "cloud.sun.fill",
                temp: 23
            ),
            HourlyForecast(
                time: "7 PM",
                conditionIconName: "cloud.fill",
                temp: 21
            ),
            HourlyForecast(
                time: "8 PM",
                conditionIconName: "cloud.fill",
                temp: 20
            ),
            HourlyForecast(
                time: "9 PM",
                conditionIconName: "cloud.fill",
                temp: 19
            )
        ]
        
        let hourlyTomorrow = [
            HourlyForecast(
                time: "12 AM",
                conditionIconName: "cloud.fill",
                temp: 18
            ),
            HourlyForecast(
                time: "6 AM",
                conditionIconName: "sun.max.fill",
                temp: 22
            ),
            HourlyForecast(
                time: "12 PM",
                conditionIconName: "sun.max.fill",
                temp: 28
            ),
            HourlyForecast(
                time: "6 PM",
                conditionIconName: "cloud.sun.fill",
                temp: 25
            ),
            HourlyForecast(
                time: "9 PM",
                conditionIconName: "cloud.fill",
                temp: 22
            )
        ]
        
        let hourlyAfterTomorrow = [
            HourlyForecast(
                time: "12 AM",
                conditionIconName: "cloud.fill",
                temp: 17
            ),
            HourlyForecast(
                time: "6 AM",
                conditionIconName: "cloud.sun.fill",
                temp: 20
            ),
            HourlyForecast(
                time: "12 PM",
                conditionIconName: "cloud.fill",
                temp: 24
            ),
            HourlyForecast(
                time: "6 PM",
                conditionIconName: "cloud.fill",
                temp: 22
            ),
            HourlyForecast(
                time: "9 PM",
                conditionIconName: "cloud.fill",
                temp: 19
            )
        ]
        
        let forecastDays = [
            ForecastDay(
                dayName: "Today",
                conditionIconName: "sun.max.fill",
                minTemp: 20,
                maxTemp: 30,
                hourly: hourlyToday
            ),
            ForecastDay(
                dayName: "Tomorrow",
                conditionIconName: "cloud.sun.fill",
                minTemp: 18,
                maxTemp: 28,
                hourly: hourlyTomorrow
            ),
            ForecastDay(
                dayName: "After Tomorrow",
                conditionIconName: "cloud.fill",
                minTemp: 17,
                maxTemp: 26,
                hourly: hourlyAfterTomorrow
            )
        ]
        
        switch locationName.lowercased() {
        case "london":
            return WeatherData(
                locationName: "London",
                currentTemp: 18,
                conditionText: "Rainy",
                conditionIconName: "cloud.rain.fill",
                maxTempToday: 22,
                minTempToday: 15,
                forecast: forecastDays,
                visibility: "8 km",
                humidity: "80%",
                feelsLike: "17°C",
                pressure: "1008 hPa"
            )
        case "tokyo":
            return WeatherData(
                locationName: "Tokyo",
                currentTemp: 22,
                conditionText: "Cloudy",
                conditionIconName: "cloud.fill",
                maxTempToday: 26,
                minTempToday: 18,
                forecast: forecastDays,
                visibility: "9 km",
                humidity: "70%",
                feelsLike: "23°C",
                pressure: "1010 hPa"
            )
        case "paris":
            return WeatherData(
                locationName: "Paris",
                currentTemp: 20,
                conditionText: "Partly Cloudy",
                conditionIconName: "cloud.sun.fill",
                maxTempToday: 25,
                minTempToday: 16,
                forecast: forecastDays,
                visibility: "10 km",
                humidity: "65%",
                feelsLike: "21°C",
                pressure: "1011 hPa"
            )
        case "new york":
            return WeatherData(
                locationName: "New York",
                currentTemp: 24,
                conditionText: "Sunny",
                conditionIconName: "sun.max.fill",
                maxTempToday: 29,
                minTempToday: 19,
                forecast: forecastDays,
                visibility: "10 km",
                humidity: "55%",
                feelsLike: "25°C",
                pressure: "1013 hPa"
            )
        default:
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
    
    func fetchDefaultLocations() -> [WeatherData] {
        return [
            fetchWeatherData(for: "Cairo"),
            fetchWeatherData(for: "London"),
            fetchWeatherData(for: "Tokyo")
        ]
    }
}
