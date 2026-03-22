//
//  ContentView.swift
//  MyMap
//
//  Created by stud on 23/10/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "map")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("My Map")
            TabViewContent()
        }
        .padding()
        .accessibilityIdentifier("MainContentView")
    }
}

#Preview {
    ContentView()
}

