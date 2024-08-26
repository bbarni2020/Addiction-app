//
//  SettingsView.swift
//  Addiction Free
//
//  Created by MasterbrosDev, Barnabás on 26/08/2024.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @State private var isFaceIDEnabled: Bool = false
    @State private var isNotificationsEnabled: Bool = true
    @Environment(\.modelContext) private var modelContext
    @State private var showingAlert = false
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
                        
                        NavigationLink(destination: PincodeSet()) {
                            Text("Reset PIN")
                                .foregroundStyle(.blue)
                        }
                    }
                                            
                        //Button(action: shareApp) {
                        //    Text("Share This App")
                        //}
                    Section(header: Text("Reset")) {
                        Button() {
                            showingAlert = true
                        } label: {
                            Text("Delete All Data")
                                .foregroundStyle(.red)
                        }
                        .alert("Are you sure? This action cannot be undone.", isPresented: $showingAlert){
                            Button("Yes", role: .destructive) {
                                deleteAllData()
                            }
                            Button("No", role: .cancel) {}
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
    
    private func deleteAllData() {
        showingAlert = true
        let fetchDescriptorForActivities = FetchDescriptor<Activity>()
                if let activities = try? modelContext.fetch(fetchDescriptorForActivities) {
                    for activity in activities {
                        modelContext.delete(activity)
                    }
                }

                let fetchDescriptorStatus = FetchDescriptor<Status>()
                if let statuses = try? modelContext.fetch(fetchDescriptorStatus) {
                    for status in statuses {
                        modelContext.delete(status)
                    }
                }

                try? modelContext.save()
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
