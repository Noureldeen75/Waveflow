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
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $isShowingSavedLocations) {
                SavedLocationsView(viewModel: viewModel)
            }
        }
    }
}

struct WeatherPageView: View {
    let weatherData: WeatherData
    let backgroundImageName: String
    let textColor: Color
    let onFavTapped: () -> Void
    
    var body: some View {
        ZStack {
            Image(backgroundImageName)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        Button(action: onFavTapped) {
                            Image(systemName: "heart.fill")
                                .font(.title2)
                                .foregroundColor(textColor)
                        }
                        .padding(.trailing, 20)
                    }
                    .padding(.top, 10)
                    
                    VStack(spacing: 8) {
                        Text(weatherData.locationName)
                            .font(.system(size: 34, weight: .medium))
                            .foregroundColor(textColor)
                        
                        Text("\(Int(weatherData.currentTemp))°")
                            .font(.system(size: 72, weight: .thin))
                            .foregroundColor(textColor)
                        
                        HStack(spacing: 8) {
                            Image(systemName: weatherData.conditionIconName)
                                .font(.title)
                            
                            Text(weatherData.conditionText)
                                .font(.title3)
                                .fontWeight(.medium)
                        }
                        .foregroundColor(textColor)
                        
                        Text("H: \(Int(weatherData.maxTempToday))°  L: \(Int(weatherData.minTempToday))°")
                            .font(.body)
                            .fontWeight(.medium)
                            .foregroundColor(textColor)
                    }
                    .padding(.top, 20)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(spacing: 6) {
                            Image(systemName: "calendar")
                            Text("3-DAY FORECAST")
                                .font(.caption)
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(textColor.opacity(0.7))
                        
                        Divider()
                            .background(textColor.opacity(0.3))
                        
                        ForEach(weatherData.forecast) { day in
                            NavigationLink(
                                destination: HourlyForecastView(
                                    dayName: day.dayName,
                                    hourlyForecasts: day.hourly,
                                    backgroundImageName: backgroundImageName,
                                    textColor: textColor
                                )
                            ) {
                                HStack {
                                    Text(day.dayName)
                                        .frame(
                                            width: 120,
                                            alignment: .leading
                                        )
                                        .font(.body)
                                        .fontWeight(.medium)
                                    
                                    Spacer()
                                    
                                    Image(systemName: day.conditionIconName)
                                        .font(.title3)
                                    
                                    Spacer()
                                    
                                    Text("\(Int(day.minTemp))° - \(Int(day.maxTemp))°")
                                        .frame(
                                            width: 80,
                                            alignment: .trailing
                                        )
                                        .font(.body)
                                        .fontWeight(.medium)
                                }
                                .padding(.vertical, 4)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                    .background(
                        textColor == .black
                        ? Color.white.opacity(0.2)
                        : Color.black.opacity(0.3)
                    )
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.top, 24)
                    
                    VStack(spacing: 12) {
                        HStack(spacing: 12) {
                            WeatherDetailCard(
                                title: "Visibility",
                                value: weatherData.visibility,
                                iconName: "eye.fill",
                                textColor: textColor
                            )
                            WeatherDetailCard(
                                title: "Humidity",
                                value: weatherData.humidity,
                                iconName: "humidity.fill",
                                textColor: textColor
                            )
                        }
                        
                        HStack(spacing: 12) {
                            WeatherDetailCard(
                                title: "Feels Like",
                                value: weatherData.feelsLike,
                                iconName: "thermometer.medium",
                                textColor: textColor
                            )
                            WeatherDetailCard(
                                title: "Pressure",
                                value: weatherData.pressure,
                                iconName: "gauge.with.needle",
                                textColor: textColor
                            )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 16)
                    .padding(.bottom, 40)
                }
            }
        }
    }
}

struct WeatherDetailCard: View {
    let title: String
    let value: String
    let iconName: String
    let textColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 4) {
                Image(systemName: iconName)
                    .font(.caption)
                Text(title.uppercased())
                    .font(.caption2)
                    .fontWeight(.semibold)
            }
            .foregroundColor(textColor.opacity(0.7))
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(textColor)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            textColor == .black
            ? Color.white.opacity(0.2)
            : Color.black.opacity(0.3)
        )
        .cornerRadius(15)
    }
}

#Preview {
    ContentView(
        viewModel: WeatherViewModel(
            weatherService: WeatherService()
        )
    )
}
