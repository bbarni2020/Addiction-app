//
//  ContentView.swift
//  Addiction Free
//
//  Created by MasterbrosDev, Barnabás on 16/08/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var isAuthenticated = false
    var body: some View {
        ZStack {
            if isAuthenticated {
                TabView {
                    Home()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    AddictionTrack()
                        .tabItem {
                            Label("MyPage", systemImage: "pencil.tip")
                        }
                }
            } else {
                PasswordView(isAuthenticated: $isAuthenticated)
                }
            }
        }
        
    }

#Preview {
    ContentView()
}
