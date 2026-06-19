//
//  ContentView.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 19/06/2026.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        ZStack {
            Image(viewModel.backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                VStack(spacing: 8) {
                    Text(viewModel.weatherData.locationName)
                        .font(.system(size: 34, weight: .medium))
                        .foregroundColor(viewModel.textColor)
                    
                    Text("\(Int(viewModel.weatherData.currentTemp))°")
                        .font(.system(size: 72, weight: .thin))
                        .foregroundColor(viewModel.textColor)
                    
                    HStack(spacing: 8) {
                        Image(systemName: viewModel.weatherData.conditionIconName)
                            .font(.title)
                        
                        Text(viewModel.weatherData.conditionText)
                            .font(.title3)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(viewModel.textColor)
                    
                    Text("H: \(Int(viewModel.weatherData.maxTempToday))°  L: \(Int(viewModel.weatherData.minTempToday))°")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(viewModel.textColor)
                }
                .padding(.top, 40)
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView(viewModel: WeatherViewModel(weatherService: MockWeatherService()))
}
