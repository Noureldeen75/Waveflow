//
//  ContentView.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 19/06/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("morning")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Text("WeatherCast App Placeholder")
                .font(.title)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    ContentView()
}
