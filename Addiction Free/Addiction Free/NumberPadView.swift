//
//  NumberPadView.swift
//  Addiction Free
//
//  Created by ScriptKid on 17/08/2024.
//

import SwiftUI

struct NumberPadView: View {
    @Binding var passcode: String
    private let colums: [GridItem] = [
        .init(),
        .init(),
        .init()
    ]
    var body: some View {
        LazyVGrid(columns: colums){
            ForEach(1...9, id: \.self) {index in
                Button {
                    addValue(index)
                } label: {
                    Text("\(index)")
                        .font(.title)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .contentShape(.rect)
                }
            }
            Button {
                removeValue()
            } label: {
                Image(systemName: "delete.backward")
                    .font(.title)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .contentShape(.rect)
            }
            Button {
                addValue(0)
            } label: {
                Text("0")
                    .font(.title)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .contentShape(.rect)
            }
            //Button {
            //
            //} label: {
            //    Image(systemName: "faceid")
            //        .font(.title)
            //        .frame(maxWidth: .infinity)
            //        .padding(.vertical, 16)
            //        .contentShape(.rect)
            //weh}
            
        }
        .foregroundStyle(.primary)
        
    }
    private func addValue(_ value: Int) {
        if passcode.count < 6 {
            passcode += "\(value)"
        }
    }
    private func removeValue() {
        if !passcode.isEmpty {
            passcode.removeLast()
        }
    }
}

#Preview {
    NumberPadView(passcode: .constant(""))
}
