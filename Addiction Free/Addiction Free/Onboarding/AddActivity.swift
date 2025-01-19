//
//  AddActivity.swift
//  Addiction Free
//
//  Created by ScriptKid on 27/08/2024.
//

import SwiftUI
import SwiftData

struct AddActivity: View {
    @Binding var selected: Bool
    @Environment(\.modelContext) private var modelContext
    @State var text = ""

        let addictions = [
            ("Smoking", "🚬")
        ]
        
        var body: some View {}
                
            
        
    }

#Preview {
    AddActivity(selected: .constant(false))
}
