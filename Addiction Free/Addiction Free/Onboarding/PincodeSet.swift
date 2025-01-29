//
//  PincodeSet.swift
//  Addiction Free
//
//  Created by ScriptKid on 26/08/2024.
//

import SwiftUI
import CoreHaptics
import SwiftData
struct PincodeSet: View {
    @State var isFirst = true
    @State private var passcode = ""
    @State private var Fpasscode = ""
    @State private var Spasscode = ""
    @State var wrong = false
    @State var savedBio = false
    @State private var showingPop = false
    @State var ready = false
    @State var home = false
    @State var nextB = true
    let biomanager = FaceIDManager()
    let faceid = UserDefaults.standard.bool(forKey: "faceid")
    let screen = UIScreen.main.bounds.width
    let isFirstTime = UserDefaults.standard.bool(forKey: "firstTime")
    @State private var engine: CHHapticEngine?
    @State private var selected = false
    @State private var selectedDate = Date()
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        if ready == false {
            VStack {
                VStack(spacing: 48) {
                    Text("Enter your PIN")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    
                    if isFirst == true {
                        Text("Create your 6-digit pin for this app")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 35)
                    } else {
                        Text("Confirm your 6-digit pin for this app")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 35)
                    }
                    if wrong {
                        Text("Passcodes do not match. Please try again.")
                            .font(.caption)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.red)
                            .padding()
                    }
                }
                .padding(.top)
                PasscodeIndicatorView(passcode: $passcode)
                Spacer()
                NumberPadView(passcode: $passcode)
            }
            .onChange(of: passcode, {oldValue, newValue in
                make()})
        } else {
            if home {
                Home()
            } else {
                VStack {
                    if isFirstTime {
                        
                    } else {
                        if nextB {
                            VStack {
                                Image(systemName: "checkmark.circle")
                                    .foregroundStyle(Color.green)
                                    .font(.system(size: screen * 0.17))
                                Text("The pincode is saved successfully.")
                                    .font(.headline)
                                    .padding()
                                Button {
                                    showingPop = true
                                } label: {
                                    Text("Select your addiction")
                                        .fontWeight(.bold)
                                        .padding()
                                        .background(Color.primary)
                                        .foregroundStyle(Color.secondary)
                                        .cornerRadius(8)
                                        .frame(width: screen * 0.7)
                                }
                            }
                        } else {
                                
                            Text("Set the last date of your addiction")
                                .fontWeight(.bold)
                                .font(.system(size: 25))
                                .padding()
                                .foregroundStyle(Color.primary)
                                .frame(maxWidth: .infinity, alignment: .center)
                            DatePicker(
                                "Select Date",
                                selection: $selectedDate,
                                in: ...Date(),
                                displayedComponents: [.date, .hourAndMinute]
                            )
                            .datePickerStyle(.graphical)
                            .padding()
                            Button {
                                let fetchDescriptor = FetchDescriptor<Activity>()
                                
                                let activities = try? modelContext.fetch(fetchDescriptor)
                                let smokeActivity: Activity

                                if let activity = activities?.first {
                                    smokeActivity = activity
                                } else {
                                    smokeActivity = Activity(name: "🚬 Smoke", hexColor: "000000")
                                    modelContext.insert(smokeActivity)
                                }

                                let newStatus = Status(date: selectedDate)
                                smokeActivity.statuses.append(newStatus)

                                try? modelContext.save()
                                NotificationManager().turnOnNotifications()
                                let _: Void = UserDefaults.standard.set(
                                    true,
                                    forKey: "faceid"
                                )
                                AFFunc().refreshWidget()
                                home = true
                            } label: {
                                Text("Save")
                                    .fontWeight(.bold)
                                    .padding()
                                    .background(Color.primary)
                                    .foregroundStyle(Color.secondary)
                                    .cornerRadius(8)
                                    .frame(width: screen * 0.7)
                            }
                            Text("or")
                                .font(.title3)
                                .frame(maxWidth: .infinity, minHeight: 60)
                                .foregroundColor(Color.primary)
                                .cornerRadius(15)
                                .padding(.horizontal)
                            Button {
                                NotificationManager().turnOnNotifications()
                                let _: Void = UserDefaults.standard.set(
                                    true,
                                    forKey: "faceid"
                                )
                                AFFunc().refreshWidget()
                                home = true
                            } label: {
                                Text("Make the first log later")
                                    .fontWeight(.bold)
                                    .padding()
                                    .background(Color.primary)
                                    .foregroundStyle(Color.secondary)
                                    .cornerRadius(8)
                                    .frame(width: screen * 0.7)
                            }
                        }
                    }
                }
                .onAppear(perform: load)
                .popover(isPresented: $showingPop) {
                    AddActivity(selected: $selected)
                        .onChange(of: selected){
                            if selected {
                                nextB = false
                                showingPop = false
                            }
                        }
                }
            }
        }
    }
    
    private func make() {
        guard passcode.count == 6 else { return }
        Task {
            try? await Task.sleep(nanoseconds: 125_000_000)
            if isFirst == true {
                Fpasscode = passcode
                passcode = ""
                isFirst = false
            } else {
                Spasscode = passcode
                passcode = ""
                if Spasscode == Fpasscode {
                    KeychainHelper.shared.deletePinCode()
                    KeychainHelper.shared.savePinCode(Spasscode)
                    ready = true
                } else {
                    Spasscode = ""
                    Fpasscode = ""
                    passcode = ""
                    isFirst = true
                    wrong = true
                }
            }
        }
    }
    private func load() {
        biomanager.enableFaceID()
    }
    
    
}

#Preview {
    PincodeSet()
}
