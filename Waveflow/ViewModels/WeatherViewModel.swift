//
//  WeatherViewModel.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 19/06/2026.
//

import SwiftUI

class WeatherViewModel: ObservableObject {
    @Published var weatherData: WeatherData
    private let weatherService: WeatherServiceProtocol
    
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
        self.weatherData = weatherService.fetchWeatherData()
    }
    
    var backgroundImageName: String {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour >= 5 && hour < 18 {
            return "morning"
        } else {
            return "night"
        }
    }
    
    var textColor: Color {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour >= 5 && hour < 18 {
            return .black
        } else {
            return .white
        }
    }
}
