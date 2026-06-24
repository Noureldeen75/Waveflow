//
//  SearchInputBar.swift
//  Waveflow
//
//  Created by Noureldeen Osama on 24/06/2026.
//

import SwiftUI

struct SearchInputBar: View {
    @Binding var searchQuery: String
    let textColor: Color
    let onQueryChanged: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(textColor.opacity(0.6))
            
            TextField("Search Countries", text: $searchQuery)
                .foregroundColor(textColor)
                .onChange(of: searchQuery) { _ in
                    onQueryChanged()
                }
        }
        .padding(10)
        .background(
            textColor == .black
            ? Color.white.opacity(0.2)
            : Color.black.opacity(0.3)
        )
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.top, 10)
    }
}
