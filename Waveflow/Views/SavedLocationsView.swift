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
                
                SavedLocationsListView(
                    viewModel: viewModel,
                    onSelect: { index in
                        viewModel.selectLocation(at: index)
                        dismiss()
                    }
                )
            }
            
            NavigationLink(
                destination: SearchLocationsView(viewModel: viewModel),
                isActive: $isShowingSearch
            ) {
                EmptyView()
            }
        }
        .navigationTitle("Weather")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    isShowingSearch = true
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(viewModel.textColor)
                }
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
