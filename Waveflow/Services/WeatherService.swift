//
//  WeatherService.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 19/06/2026.
//

import Foundation

protocol WeatherServiceProtocol {
    func fetchWeather(
        for query: String,
        completion: @escaping (WeatherData?) -> Void
    )
}

class WeatherService: WeatherServiceProtocol {
    private let apiKey = "afad2da22c6947078c7131923262306"
    private let baseURL = "http://api.weatherapi.com/v1/forecast.json"
    
    func fetchWeather(
        for query: String,
        completion: @escaping (WeatherData?) -> Void
    ) {
        let encodedQuery = query.addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        ) ?? query
        
        let urlString = "\(baseURL)?key=\(apiKey)&q=\(encodedQuery)&days=3&aqi=yes&alerts=no"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            do {
                let apiResponse = try JSONDecoder().decode(
                    APIWeatherResponse.self,
                    from: data
                )
                let weatherData = self.mapToWeatherData(apiResponse)
                DispatchQueue.main.async { completion(weatherData) }
            } catch {
                print("Decoding error: \(error)")
                DispatchQueue.main.async { completion(nil) }
            }
        }.resume()
    }
    
    private func mapToWeatherData(_ response: APIWeatherResponse) -> WeatherData {
        let forecastDays = response.forecast.forecastday.enumerated().map { index, day in
            let dayName: String
            switch index {
            case 0: dayName = "Today"
            case 1: dayName = "Tomorrow"
            default: dayName = "After Tomorrow"
            }
            
            let hourlyItems = day.hour.map { hour in
                let timeString = formatHourTime(hour.time)
                return HourlyForecast(
                    time: timeString,
                    conditionIconName: mapConditionToSFSymbol(hour.condition.code),
                    temp: hour.temp_c
                )
            }
            
            return ForecastDay(
                dayName: dayName,
                conditionIconName: mapConditionToSFSymbol(day.day.condition.code),
                minTemp: day.day.mintemp_c,
                maxTemp: day.day.maxtemp_c,
                hourly: hourlyItems
            )
        }
        
        let todayForecast = response.forecast.forecastday.first
        
        return WeatherData(
            locationName: response.location.name,
            currentTemp: response.current.temp_c,
            conditionText: response.current.condition.text,
            conditionIconName: mapConditionToSFSymbol(response.current.condition.code),
            maxTempToday: todayForecast?.day.maxtemp_c ?? 0,
            minTempToday: todayForecast?.day.mintemp_c ?? 0,
            forecast: forecastDays,
            visibility: "\(response.current.vis_km) km",
            humidity: "\(response.current.humidity)%",
            feelsLike: "\(Int(response.current.feelslike_c))°C",
            pressure: "\(Int(response.current.pressure_mb)) hPa"
        )
    }
    
    private func formatHourTime(_ timeString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = formatter.date(from: timeString) else { return timeString }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "h a"
        return outputFormatter.string(from: date)
    }
    
    private func mapConditionToSFSymbol(_ code: Int) -> String {
        switch code {
        case 1000: return "sun.max.fill"
        case 1003: return "cloud.sun.fill"
        case 1006: return "cloud.fill"
        case 1009: return "smoke.fill"
        case 1030, 1135, 1147: return "cloud.fog.fill"
        case 1063, 1150, 1153, 1180, 1183: return "cloud.drizzle.fill"
        case 1066, 1210, 1213: return "cloud.snow.fill"
        case 1069, 1204, 1207, 1249, 1252: return "cloud.sleet.fill"
        case 1072, 1168, 1171: return "cloud.hail.fill"
        case 1087: return "cloud.bolt.fill"
        case 1114, 1117: return "wind.snow"
        case 1186, 1189: return "cloud.rain.fill"
        case 1192, 1195, 1243, 1246: return "cloud.heavyrain.fill"
        case 1198, 1201: return "cloud.rain.fill"
        case 1216, 1219, 1222, 1225, 1255, 1258: return "cloud.snow.fill"
        case 1237, 1261, 1264: return "cloud.hail.fill"
        case 1240: return "cloud.rain.fill"
        case 1273: return "cloud.bolt.rain.fill"
        case 1276: return "cloud.bolt.rain.fill"
        case 1279, 1282: return "cloud.bolt.fill"
        default: return "cloud.fill"
        }
    }
}
