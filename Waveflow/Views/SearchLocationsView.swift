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
        ZStack {
            Image(viewModel.backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                SearchInputBar(
                    searchQuery: $viewModel.searchQuery,
                    textColor: viewModel.textColor,
                    onQueryChanged: {
                        viewModel.filterCountries()
                    }
                )
                
                SearchResultsListView(
                    viewModel: viewModel,
                    onSelect: { country in
                        viewModel.addLocation(country: country)
                        viewModel.searchQuery = ""
                        dismiss()
                    }
                )
            }
        }
        .navigationTitle("Search Countries")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.filterCountries()
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
