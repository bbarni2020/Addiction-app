//
//  SettingsView.swift
//  Addiction Free
//
//  Created by MasterbrosDev, Barnabás on 26/08/2024.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    var body: some View {
            Text("Version 0.1.1 (Beta)")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundStyle(.gray)
            Text("Made by MasterBros Developers, Barnabás")
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundStyle(.gray)
                .padding(.all)
        }
        .onChange(of: isFaceIDEnabled, {oldValue, newValue in
            setbio()})
        .onChange(of: isNotificationsEnabled, {oldValue, newValue in
            notification()})
        .onAppear{load()}
    }
#Preview {
    SettingsView()
}
