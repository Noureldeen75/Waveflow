//
//  WaveflowApp.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 19/06/2026.
//

import SwiftUI

@main
struct WaveflowApp: App {
    @StateObject private var viewModel = WeatherViewModel(
        weatherService: WeatherService()
    )
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
