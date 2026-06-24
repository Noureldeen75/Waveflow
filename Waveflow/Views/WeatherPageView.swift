//
//  WeatherPageView.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 24/06/2026.
//

import SwiftUI

struct WeatherPageView: View {
    let weatherData: WeatherData
    let backgroundImageName: String
    let textColor: Color
    let onFavTapped: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(backgroundImageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                
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
                        .padding(.top, 50)
                        
                        WeatherHeaderView(
                            weatherData: weatherData,
                            textColor: textColor
                        )
                        .padding(.top, 20)
                        
                        ThreeDayForecastView(
                            forecastDays: weatherData.forecast,
                            backgroundImageName: backgroundImageName,
                            textColor: textColor
                        )
                        .padding(.top, 24)
                        
                        WeatherDetailGridView(
                            weatherData: weatherData,
                            textColor: textColor
                        )
                        .padding(.top, 16)
                        .padding(.bottom, 40)
                    }
                }
            }
        }
    }
}
