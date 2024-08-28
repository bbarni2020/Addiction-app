//
//  SettingsView.swift
//  Addiction Free
//
//  Created by MasterbrosDev, Barnabás on 26/08/2024.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @State private var isNotificationsEnabled: Bool = false
    @Environment(\.modelContext) private var modelContext
    @State private var showingAlert = false
    @State private var showingAlert2 = false
    let faceid = UserDefaults.standard.bool(forKey: "faceid")
    let bio = UserDefaults.standard.string(forKey: "bio")
    @State private var isFaceIDEnabled: Bool = true
    let not = NotificationManager()
    var body: some View {
        VStack{
            List {
                Section(header: Text("General")) {
                    Toggle(isOn: $isNotificationsEnabled) {
                        Text("Notifications")
                    }
                    Button(action: reviewApp) {
                        Text("Review App")
                            .foregroundStyle(.gray)
                    }
                }
                Section(header: Text("Security")){
                    if bio == "face" {
                        Toggle(isOn: $isFaceIDEnabled) {
                            Text("Face ID")
                        }
                    }
                    if bio == "touch" {
                        Toggle(isOn: $isFaceIDEnabled) {
                            Text("Touch ID")
                        }
                    }
                    
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
                    
                    Button() {
                        showingAlert2 = true
                    } label: {
                        Text("Reset App")
                            .foregroundStyle(.red)
                    }
                    .alert("Are you sure? This action is irreversible. All data will be lost, and the app will close afterward. You can reopen it afterward.", isPresented: $showingAlert2){
                        Button("Reset App", role: .destructive) {
                            resetApp()
                        }
                        Button("Cancel", role: .cancel) {}
                    }
                }
            }
            Text("Version 0.1 (Beta)")
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
        .onChange(of: isFaceIDEnabled, {oldValue, newValue in
            setbio()})
        .onChange(of: isNotificationsEnabled, {oldValue, newValue in
            notification()})
        .onAppear{load()}
    }
    
    private func load() {
        if faceid == false {
            isFaceIDEnabled = false
        }
        if faceid == true {
            isFaceIDEnabled = true
        }
        if not.areNotificationsTurnedOn() {
            isNotificationsEnabled = true
        } else {
            isNotificationsEnabled = false
        }
    }
    private func deleteAllData() {
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
        deleteAllData()
        KeychainHelper.shared.deletePinCode()
        let _: Void = UserDefaults.standard.set(false, forKey: "firstTime")
        UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            exit(0)}
    }
    
    private func reviewApp() {
        // review link
    }
    
    private func shareApp() {
        let activityViewController = UIActivityViewController(activityItems: ["Check out the app that helps you get over your addictions! Here's the link: www.wehavenodomainyet.com"], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
    private func setbio() {
        if isFaceIDEnabled {
            let _: Void = UserDefaults.standard.set(true, forKey: "faceid")
        } else {
            let _: Void = UserDefaults.standard.set(false, forKey: "faceid")
        }
    }
    private func notification() {
        if isNotificationsEnabled {
            not.turnOnNotifications()
        } else {
            not.turnOffNotifications()
        }
    }
}
#Preview {
    SettingsView()
}
