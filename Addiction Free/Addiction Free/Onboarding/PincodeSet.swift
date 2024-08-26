//
//  PincodeSet.swift
//  Addiction Free
//
//  Created by ScriptKid on 26/08/2024.
//

import SwiftUI

struct PincodeSet: View {
    @State var isFirst = true
    @State var ready = false
    @State private var passcode = ""
    @State private var Fpasscode = ""
    @State private var Spasscode = ""
    @State var wrong = false
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
                .onAppear{
                    KeychainHelper.shared.deletePinCode()
                }
            } else {
                    VStack {
                        Image(systemName: "checkmark.circle")
                            .foregroundStyle(Color.primary)
                            .padding(.all)
                            .scaledToFit()
                            .frame(width: 1000)
                        Text("The pincode is saved successfully.")
                            .font(.headline)
                            .padding()
                        Button {
                            
                        } label: {
                            Text("Next")
                                .fontWeight(.bold)
                                .padding()
                                .background(Color.primary)
                                .foregroundStyle(Color.secondary)
                                .cornerRadius(8)
                                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
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
}

#Preview {
    PincodeSet()
}
