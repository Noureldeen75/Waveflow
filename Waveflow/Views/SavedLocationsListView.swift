//
//  SavedLocationsListView.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 24/06/2026.
//

import SwiftUI

struct SavedLocationsListView: View {
    @ObservedObject var viewModel: WeatherViewModel
    let onSelect: (Int) -> Void
    
    var body: some View {
        List {
            ForEach(
                0..<viewModel.savedLocations.count,
                id: \.self
            ) { index in
                let location = viewModel.savedLocations[index]
                Button(action: {
                    onSelect(index)
                }) {
                    SavedLocationRow(
                        location: location,
                        textColor: viewModel.textColor
                    )
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
