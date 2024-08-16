//
//  ContentView.swift
//  Addiction Free
//
//  Created by MasterbrosDev, Barnabás on 16/08/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Home")
                    .font(.custom(<#String#>, size: 22))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.primary)
                
                Spacer()
                
                Text("Are you still doing no cigarette?🚭")
                    .font(.custom(<#String#>, size: 18))
                    .padding(.bottom, 12)
                
                Button(action: {
                    print("Button pressed ...")
                }) {
                    Text("Still doing it")
                        .font(.custom(<#String#>, size: 14))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Button(action: {
                    print("Button pressed ...")
                }) {
                    Text("I failed")
                        .font(.custom(<#String#>, size: 14))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                Button(action: {
                    print("Button pressed ...")
                }) {
                    Text("Add new addiction")
                        .font(.custom(<#String#>, size: 14))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.primary)
                        .cornerRadius(8)
                }
                .padding(.bottom)
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ContentView()
}
