//
//  PasswordView.swift
//  Addiction Free
//
//  Created by MasterbrosDev, Barnabás on 17/08/2024.
//

import SwiftUI

struct PasswordView: View {
    @Binding var isAuthenticated: Bool
    @State private var passcode = ""
    @AppStorage("pincode") private var pincode : String = "111111"
    var body: some View {
        VStack {
            VStack(spacing: 48) {
                Text("Enter PIN")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                Text("Please enter your 6-digit pin to securely access the Addiction Free app.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 35)
            }
            .padding(.top)
            PasscodeIndicatorView(passcode: $passcode)
            Spacer()
            NumberPadView(passcode: $passcode)
        }
        .onChange(of: passcode, {oldValue, newValue in
            verifyPasscode()})
    }
        private func verifyPasscode() {
            guard passcode.count == 6 else { return }
            print(pincode)
            print(passcode)
            Task {
                try? await Task.sleep(nanoseconds: 125_000_000)
                isAuthenticated = passcode == pincode
                passcode = ""
            }
        }
}

#Preview {
    PasswordView(isAuthenticated: .constant(false))
}
