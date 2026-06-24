//
//  ContentView.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 19/06/2026.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @State private var isShowingSavedLocations = false
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    Image(viewModel.backgroundImageName)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    
                    ProgressView("Loading...")
                        .foregroundColor(viewModel.textColor)
                        .tint(viewModel.textColor)
                } else {
                    TabView(selection: $viewModel.selectedLocationIndex) {
                        ForEach(
                            0..<viewModel.savedLocations.count,
                            id: \.self
                        ) { index in
                            WeatherPageView(
                                weatherData: viewModel.savedLocations[index],
                                backgroundImageName: viewModel.backgroundImageName,
                                textColor: viewModel.textColor,
                                onFavTapped: {
                                    isShowingSavedLocations = true
                                }
                            )
                            .tag(index)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .ignoresSafeArea()
                }
                
                NavigationLink(
                    destination: SavedLocationsView(viewModel: viewModel),
                    isActive: $isShowingSavedLocations
                ) {
                    EmptyView()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ContentView(
        viewModel: WeatherViewModel(
            weatherService: WeatherService()
        )
    )
}
