//
//  Home.swift
//  Addiction Free
//
//  Created by MasterbrosDev, Barnabás on 17/08/2024.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            VStack {
                CalendarHeader()
                    .padding(.top, 12)
                Streak()
                Text("How have you been doing with staying clear of your addiction?")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
                    .cornerRadius(12)
                AddictionTrack()

            }
            .navigationTitle("Home")
            .toolbar {
                NavigationLink(destination: CalendarHeader()) {
                    Image(systemName: "gear")
                        .foregroundStyle(Color.primary)
                }
            }
        }
    }
}

#Preview {
    Home()
}
