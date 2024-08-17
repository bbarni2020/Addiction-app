//
//  PasscodeIndicatorView.swift
//  Addiction Free
//
//  Created by ScriptKid on 17/08/2024.
//

import SwiftUI

struct PasscodeIndicatorView: View {
    @Binding var passcode: String
    var body: some View {
        HStack(spacing: 32) {
            ForEach(0 ..< 6) {index in
                Circle()
                    .fill(passcode.count > index ? .primary : Color(.white))
                    .frame(width: 20, height: 20)
                    .overlay {
                        Circle()
                            .stroke(.black, lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    }
            }
        }
    }
}

#Preview {
    PasscodeIndicatorView(passcode: .constant(""))
}
