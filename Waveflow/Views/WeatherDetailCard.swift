//
//  WeatherDetailCard.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 24/06/2026.
//

import SwiftUI

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
