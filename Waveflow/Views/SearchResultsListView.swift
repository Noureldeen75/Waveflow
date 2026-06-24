//
//  SearchResultsListView.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 24/06/2026.
//

import SwiftUI

struct SearchResultsListView: View {
    @ObservedObject var viewModel: WeatherViewModel
    let onSelect: (CountryEntry) -> Void
    
    var body: some View {
        List {
            ForEach(viewModel.filteredCountries) { country in
                Button(action: {
                    onSelect(country)
                }) {
                    SearchCountryRow(
                        countryName: country.name,
                        textColor: viewModel.textColor
                    )
                }
                .listRowBackground(
                    viewModel.textColor == .black
                    ? Color.white.opacity(0.2)
                    : Color.black.opacity(0.3)
                )
            }
        }
        .listStyle(PlainListStyle())
        .background(Color.clear)
    }
}
