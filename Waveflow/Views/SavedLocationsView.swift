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
    @State private var isShowingSearch = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(viewModel.backgroundImageName)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    Text("SAVED LOCATIONS")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(viewModel.textColor.opacity(0.7))
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    List {
                        ForEach(
                            0..<viewModel.savedLocations.count,
                            id: \.self
                        ) { index in
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
                                            .foregroundColor(
                                                viewModel.textColor.opacity(0.7)
                                            )
                                    }
                                    
                                    Spacer()
                                    
                                    Text("\(Int(location.currentTemp))°")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(viewModel.textColor)
                                }
                            }
                            .listRowBackground(
                                viewModel.textColor == .black
                                ? Color.white.opacity(0.2)
                                : Color.black.opacity(0.3)
                            )
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                if index > 0 {
                                    viewModel.removeLocation(at: index)
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.clear)
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
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingSearch = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(viewModel.textColor)
                    }
                }
            }
            .sheet(isPresented: $isShowingSearch) {
                SearchLocationsView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    SavedLocationsView(
        viewModel: WeatherViewModel(
            weatherService: WeatherService()
        )
    )
}
