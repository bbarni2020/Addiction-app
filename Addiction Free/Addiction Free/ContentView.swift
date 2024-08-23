//
//  ContentView.swift
//  Addiction Free
//
//  Created by MasterbrosDev, Barnabás on 16/08/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var isAuthenticated = true
    var body: some View {
        ZStack {
            if isAuthenticated {
                    Home()
            } else {
                PasswordView(isAuthenticated: $isAuthenticated)
                }
            }
        }
        
    }

#Preview {
    ContentView()
}
