//
//  WeatherViewModel.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 19/06/2026.
//

import SwiftUI
import SwiftData

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var savedLocations: [WeatherData] = []
    @Published var selectedLocationIndex: Int = 0
    @Published var isLoading: Bool = true
    @Published var searchQuery: String = ""
    @Published var filteredCountries: [CountryEntry] = []
    @Published var allCountries: [CountryEntry] = []
    
    private let weatherService: WeatherServiceProtocol
    private var container: ModelContainer?
    private var context: ModelContext?
    
    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
        setupSwiftData()
        loadCountries()
        fetchSavedLocations()
    }
    
    private func setupSwiftData() {
        do {
            container = try ModelContainer(for: SavedLocationEntity.self)
            if let container = container {
                context = ModelContext(container)
            }
        } catch {
            print("Failed to initialize SwiftData: \(error)")
        }
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
    
    func fetchSavedLocations() {
        isLoading = true
        
        guard let context = context else {
            fetchDefaultLocation()
            return
        }
        
        let descriptor = FetchDescriptor<SavedLocationEntity>()
        do {
            var entities = try context.fetch(descriptor)
            
            if entities.isEmpty {
                let defaultEntity = SavedLocationEntity(name: "Egypt", query: "Cairo")
                context.insert(defaultEntity)
                try? context.save()
                entities = [defaultEntity]
            }
            
            let group = DispatchGroup()
            var fetchedData: [String: WeatherData] = [:]
            
            for entity in entities {
                group.enter()
                weatherService.fetchWeather(for: entity.query) { weatherData in
                    if let weatherData = weatherData {
                        fetchedData[entity.name] = weatherData
                    }
                    group.leave()
                }
            }
            
            group.notify(queue: .main) { [weak self] in
                guard let self = self else { return }
                
                var orderedLocations: [WeatherData] = []
                for entity in entities {
                    if let data = fetchedData[entity.name] {
                        orderedLocations.append(data)
                    }
                }
                
                if orderedLocations.isEmpty {
                    self.fetchDefaultLocation()
                } else {
                    self.savedLocations = orderedLocations
                    self.selectedLocationIndex = 0
                    self.isLoading = false
                }
            }
            
        } catch {
            print("Fetch error: \(error)")
            fetchDefaultLocation()
        }
    }
    
    private func fetchDefaultLocation() {
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
        
        if let context = context {
            let entity = SavedLocationEntity(name: country.name, query: country.query)
            context.insert(entity)
            try? context.save()
        }
        
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
        
        let locationToRemove = savedLocations[index]
        
        if let context = context {
            let descriptor = FetchDescriptor<SavedLocationEntity>()
            if let entities = try? context.fetch(descriptor) {
                if let entityToDelete = entities.first(where: { $0.name.lowercased() == locationToRemove.locationName.lowercased() }) {
                    context.delete(entityToDelete)
                    try? context.save()
                }
            }
        }
        
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
