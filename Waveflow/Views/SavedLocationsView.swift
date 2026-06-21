//
//  SavedLocationsView.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 21/06/2026.
//

import SwiftUI

struct SavedLocationsView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(viewModel.backgroundImageName)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(viewModel.textColor.opacity(0.6))
                        
                        TextField(
                            "Search City",
                            text: $viewModel.searchQuery,
                            onCommit: {
                                viewModel.performSearch()
                            }
                        )
                        .foregroundColor(viewModel.textColor)
                        .onChange(of: viewModel.searchQuery) { _ in
                            viewModel.performSearch()
                        }
                    }
                    .padding(10)
                    .background(viewModel.textColor == .black ? Color.white.opacity(0.2) : Color.black.opacity(0.3))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    if !viewModel.searchResults.isEmpty {
                        VStack(alignment: .leading) {
                            Text("Search Results")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(viewModel.textColor.opacity(0.7))
                                .padding(.horizontal)
                            
                            ForEach(viewModel.searchResults) { result in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(result.locationName)
                                            .font(.headline)
                                        Text(result.conditionText)
                                            .font(.subheadline)
                                    }
                                    
                                    Spacer()
                                    
                                    Text("\(Int(result.currentTemp))°")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    
                                    Button(action: {
                                        viewModel.addLocationToSaved(result)
                                        viewModel.searchQuery = ""
                                        dismiss()
                                    }) {
                                        Image(systemName: "plus.circle.fill")
                                            .font(.title2)
                                    }
                                }
                                .foregroundColor(viewModel.textColor)
                                .padding()
                                .background(viewModel.textColor == .black ? Color.white.opacity(0.2) : Color.black.opacity(0.3))
                                .cornerRadius(10)
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top, 10)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Saved Locations")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(viewModel.textColor.opacity(0.7))
                            .padding(.horizontal)
                        
                        List {
                            ForEach(0..<viewModel.savedLocations.count, id: \.self) { index in
                                let location = viewModel.savedLocations[index]
                                Button(action: {
                                    viewModel.selectLocation(at: index)
                                    dismiss()
                                }) {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(location.locationName)
                                                .font(.headline)
                                                .foregroundColor(viewModel.textColor)
                                            Text(location.conditionText)
                                                .font(.subheadline)
                                                .foregroundColor(viewModel.textColor.opacity(0.7))
                                        }
                                        
                                        Spacer()
                                        
                                        Text("\(Int(location.currentTemp))°")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(viewModel.textColor)
                                    }
                                }
                                .listRowBackground(viewModel.textColor == .black ? Color.white.opacity(0.2) : Color.black.opacity(0.3))
                            }
                        }
                        .listStyle(PlainListStyle())
                        .background(Color.clear)
                    }
                    .padding(.top, 15)
                }
            }
            .navigationTitle("Weather")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Close") {
                        dismiss()
                    }
                    .foregroundColor(viewModel.textColor)
                }
            }
        }
    }
}

#Preview {
    SavedLocationsView(
        viewModel: WeatherViewModel(
            weatherService: MockWeatherService()
        )
    )
}
