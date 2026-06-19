//
//  WaveflowApp.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 19/06/2026.
//

import SwiftUI

@main
struct WaveflowApp: App {
    private let viewModel = WeatherViewModel(
        weatherService: MockWeatherService()
    )
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
