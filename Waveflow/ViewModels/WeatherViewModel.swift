//
//  WeatherViewModel.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 19/06/2026.
//

import SwiftUI

class WeatherViewModel: ObservableObject {
    @Published var savedLocations: [WeatherData] = []
    @Published var selectedLocationIndex: Int = 0
    @Published var searchQuery: String = ""
    @Published var searchResults: [WeatherData] = []
    
    private let weatherService: WeatherServiceProtocol
    
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
        self.savedLocations = weatherService.fetchDefaultLocations()
    }
    
    var activeWeatherData: WeatherData {
        if selectedLocationIndex >= 0 && selectedLocationIndex < savedLocations.count {
            return savedLocations[selectedLocationIndex]
        }
        return WeatherData(
            locationName: "No Location",
            currentTemp: 0,
            conditionText: "Unknown",
            conditionIconName: "questionmark.circle",
            maxTempToday: 0,
            minTempToday: 0,
            forecast: [],
            visibility: "N/A",
            humidity: "N/A",
            feelsLike: "N/A",
            pressure: "N/A"
        )
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
    
    func performSearch() {
        guard !searchQuery.isEmpty else {
            searchResults = []
            return
        }
        
        let query = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        let matchingCities = ["cairo", "london", "tokyo", "paris", "new york"]
        
        if matchingCities.contains(query) {
            let data = weatherService.fetchWeatherData(for: query)
            searchResults = [data]
        } else {
            searchResults = []
        }
    }
    
    func addLocationToSaved(_ weatherData: WeatherData) {
        let exists = savedLocations.contains { location in
            location.locationName.lowercased() == weatherData.locationName.lowercased()
        }
        
        if !exists {
            savedLocations.append(weatherData)
            selectedLocationIndex = savedLocations.count - 1
        } else if let index = savedLocations.firstIndex(where: { $0.locationName.lowercased() == weatherData.locationName.lowercased() }) {
            selectedLocationIndex = index
        }
    }
    
    func selectLocation(at index: Int) {
        if index >= 0 && index < savedLocations.count {
            selectedLocationIndex = index
        }
    }
}
