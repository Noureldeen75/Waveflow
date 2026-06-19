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
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 6) {
                        Image(systemName: "calendar")
                        Text("3-DAY FORECAST")
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                    .foregroundColor(viewModel.textColor.opacity(0.7))
                    
                    Divider()
                        .background(viewModel.textColor.opacity(0.3))
                    
                    ForEach(viewModel.weatherData.forecast) { day in
                        HStack {
                            Text(day.dayName)
                                .frame(width: 120, alignment: .leading)
                                .font(.body)
                                .fontWeight(.medium)
                            
                            Spacer()
                            
                            Image(systemName: day.conditionIconName)
                                .font(.title3)
                            
                            Spacer()
                            
                            Text("\(Int(day.minTemp))° - \(Int(day.maxTemp))°")
                                .frame(width: 80, alignment: .trailing)
                                .font(.body)
                                .fontWeight(.medium)
                        }
                        .foregroundColor(viewModel.textColor)
                        .padding(.vertical, 4)
                    }
                }
                .padding()
                .background(viewModel.textColor == .black ? Color.white.opacity(0.2) : Color.black.opacity(0.3))
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.top, 24)
                
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView(viewModel: WeatherViewModel(weatherService: MockWeatherService()))
}
