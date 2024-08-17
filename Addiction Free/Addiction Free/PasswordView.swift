//
//  PasswordView.swift
//  Addiction Free
//
//  Created by ScriptKid on 17/08/2024.
//

import SwiftUI

struct PasswordView: View {
    @State private var passcode = ""
    var body: some View {
        VStack {
            VStack(spacing: 48) {
                Text("Enter passcode")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                Text("Please enter your 6-digit pin to securely access the Addiction Free app.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
            }
            .padding(.top)
            PasscodeIndicatorView(passcode: $passcode)
            Spacer()
            NumberPadView(passcode: $passcode)
        }
    }
}

#Preview {
    PasswordView()
}
