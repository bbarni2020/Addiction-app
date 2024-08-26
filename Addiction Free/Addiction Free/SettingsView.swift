//
//  SettingsView.swift
//  Addiction Free
//
//  Created by ScriptKid on 26/08/2024.
//

import SwiftUI

struct SettingsView: View {
    @State private var isFaceIDEnabled: Bool = false
    @State private var isNotificationsEnabled: Bool = true
    
    var body: some View {
        NavigationView {
            VStack{
                List {
                    Section(header: Text("General")) {
                        Toggle(isOn: $isNotificationsEnabled) {
                            Text("Notifications")
                        }
                        Button(action: reviewApp) {
                            Text("Review App")
                                .foregroundStyle(.blue)
                        }
                    }
                    Section(header: Text("Security")){
                        //Toggle(isOn: $isFaceIDEnabled) {
                        //    Text("Face ID")
                        //}
                        
                        Button(action: resetPIN) {
                            Text("Reset PIN")
                                .foregroundStyle(.blue)
                        }
                    }
                                            
                        //Button(action: shareApp) {
                        //    Text("Share This App")
                        //}
                    Section(header: Text("Reset")) {
                        Button(action: deleteAllData) {
                            Text("Delete All Data")
                                .foregroundStyle(.red)
                        }
                        
                        Button(action: resetApp) {
                            Text("Reset App")
                                .foregroundStyle(.red)
                        }
                    }
                }
                Text("Version 1.0")
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundStyle(.gray)
                    .padding(.top)
                Text("Made by MasterbrosDEV, Barnabás")
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundStyle(.gray)
                    .padding(.all)
            }
        }
    }
    
    private func resetPIN() {
        //reset pin
    }
    
    private func deleteAllData() {
        //delete models
    }
    
    private func resetApp() {
        //reset app
    }
    
    private func reviewApp() {
        // review link
    }
    
    private func shareApp() {
        let activityViewController = UIActivityViewController(activityItems: ["Check out the app that helps you get over your addictions! Here's the link: www.wehavenodomainyet.com"], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
}
#Preview {
    SettingsView()
}
