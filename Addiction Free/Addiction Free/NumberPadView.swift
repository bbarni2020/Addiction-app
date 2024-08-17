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
                    
                } label: {
                    Text("\(index)")
                        .font(.title)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .contentShape(.rect)
                }
            }
            Button {
                
            } label: {
                Image(systemName: "delete.backward")
                    .font(.title)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .contentShape(.rect)
            }
            Button {
                
            } label: {
                Text("0")
                    .font(.title)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .contentShape(.rect)
            }
            Button {
                
            } label: {
                Image(systemName: "faceid")
                    .font(.title)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .contentShape(.rect)
            }
            
        }
        .foregroundStyle(.primary)
        
    }
}

#Preview {
    NumberPadView(passcode: .constant(""))
}
