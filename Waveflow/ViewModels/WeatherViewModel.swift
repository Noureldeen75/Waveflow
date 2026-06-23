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
    @Published var filteredCities: [CityEntry] = []
    @Published var allCities: [CityEntry] = []
    
    private let weatherService: WeatherServiceProtocol
    
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
        loadCities()
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
    
    // MARK: - Load Cities from JSON
    
    func loadCities() {
        guard let url = Bundle.main.url(
            forResource: "egypt_cities",
            withExtension: "json"
        ) else {
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let cities = try JSONDecoder().decode(
                [CityEntry].self,
                from: data
            )
            self.allCities = cities
        } catch {
            print("Error loading cities: \(error)")
        }
    }
    
    // MARK: - Fetch Default Location (Cairo)
    
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
    
    // MARK: - Search Filtering
    
    func filterCities() {
        let query = searchQuery.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).lowercased()
        
        guard !query.isEmpty else {
            filteredCities = allCities
            return
        }
        
        filteredCities = allCities.filter {
            $0.name.lowercased().contains(query)
        }
    }
    
    // MARK: - Add Location
    
    func addLocation(city: CityEntry) {
        let alreadyExists = savedLocations.contains {
            $0.locationName.lowercased() == city.name.lowercased()
        }
        
        guard !alreadyExists else { return }
        
        weatherService.fetchWeather(for: city.query) { [weak self] weatherData in
            guard let self = self, let weatherData = weatherData else {
                return
            }
            self.savedLocations.append(weatherData)
            self.selectedLocationIndex = self.savedLocations.count - 1
        }
    }
    
    // MARK: - Remove Location
    
    func removeLocation(at index: Int) {
        guard index > 0 && index < savedLocations.count else { return }
        
        savedLocations.remove(at: index)
        
        if selectedLocationIndex >= savedLocations.count {
            selectedLocationIndex = savedLocations.count - 1
        }
    }
    
    // MARK: - Select Location
    
    func selectLocation(at index: Int) {
        if index >= 0 && index < savedLocations.count {
            selectedLocationIndex = index
        }
    }
}
