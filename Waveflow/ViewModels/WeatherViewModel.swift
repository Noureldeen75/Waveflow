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
    @Published var isLoading: Bool = true
    @Published var searchQuery: String = ""
    @Published var filteredCountries: [CountryEntry] = []
    @Published var allCountries: [CountryEntry] = []
    
    private let weatherService: WeatherServiceProtocol
    
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
        loadCountries()
        fetchDefaultLocation()
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
    
    func loadCountries() {
        guard let url = Bundle.main.url(
            forResource: "countries",
            withExtension: "json"
        ) else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let countries = try JSONDecoder().decode(
                [CountryEntry].self,
                from: data
            )
            self.allCountries = countries
        } catch {
            print("Error loading countries: \(error)")
        }
    }
    
    func fetchDefaultLocation() {
        isLoading = true
        weatherService.fetchWeather(for: "Cairo") { [weak self] weatherData in
            guard let self = self, let weatherData = weatherData else {
                self?.isLoading = false
                return
            }
            self.savedLocations = [weatherData]
            self.selectedLocationIndex = 0
            self.isLoading = false
        }
    }
    
    func filterCountries() {
        let query = searchQuery.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).lowercased()
        
        guard !query.isEmpty else {
            filteredCountries = allCountries
            return
        }
        
        filteredCountries = allCountries.filter {
            $0.name.lowercased().contains(query)
        }
    }
    
    func addLocation(country: CountryEntry) {
        let alreadyExists = savedLocations.contains {
            $0.locationName.lowercased() == country.name.lowercased()
        }
        
        guard !alreadyExists else { return }
        
        weatherService.fetchWeather(for: country.query) { [weak self] weatherData in
            guard let self = self, let weatherData = weatherData else {
                return
            }
            self.savedLocations.append(weatherData)
            self.selectedLocationIndex = self.savedLocations.count - 1
        }
    }
    
    func removeLocation(at index: Int) {
        guard index > 0 && index < savedLocations.count else { return }
        
        savedLocations.remove(at: index)
        
        if selectedLocationIndex >= savedLocations.count {
            selectedLocationIndex = savedLocations.count - 1
        }
    }
    
    func selectLocation(at index: Int) {
        if index >= 0 && index < savedLocations.count {
            selectedLocationIndex = index
        }
    }
}
