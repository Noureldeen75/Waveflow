//
//  SearchLocationsView.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 23/06/2026.
//

import SwiftUI

struct SearchLocationsView: View {
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
                            "Search Egyptian Cities",
                            text: $viewModel.searchQuery
                        )
                        .foregroundColor(viewModel.textColor)
                        .onChange(of: viewModel.searchQuery) { _ in
                            viewModel.filterCities()
                        }
                    }
                    .padding(10)
                    .background(viewModel.textColor == .black ? Color.white.opacity(0.2) : Color.black.opacity(0.3))
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    List {
                        ForEach(viewModel.filteredCities) { city in
                            Button(action: {
                                viewModel.addLocation(city: city)
                                viewModel.searchQuery = ""
                                dismiss()
                            }) {
                                HStack {
                                    Text(city.name)
                                        .font(.headline)
                                        .foregroundColor(viewModel.textColor)
                                    Spacer()
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(viewModel.textColor)
                                }
                            }
                            .listRowBackground(viewModel.textColor == .black ? Color.white.opacity(0.2) : Color.black.opacity(0.3))
                        }
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.clear)
                }
            }
            .navigationTitle("Search Cities")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        viewModel.searchQuery = ""
                        dismiss()
                    }
                    .foregroundColor(viewModel.textColor)
                }
            }
            .onAppear {
                viewModel.filterCities()
            }
        }
    }
}

#Preview {
    SearchLocationsView(
        viewModel: WeatherViewModel(
            weatherService: WeatherService()
        )
    )
}
