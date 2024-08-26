//
//  Streak.swift
//  Addiction Free
//
//  Created by ScriptKid on 26/08/2024.
//

import SwiftUI
import SwiftData

struct Streak: View {
    @Environment(\.modelContext) private var modelContext
    @State private var activity: Activity?
    var body: some View {
        VStack {
                    if let daysSinceLastLog = activity?.daysSinceLastLog {
                        Text("You haven't failed for \(daysSinceLastLog) days.")
                            .padding(.all)
                            .frame(minWidth: 900)
                            .font(.headline)
                            .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.primary, lineWidth: 2))
                    } else {
                        Text("No addictions recorded yet.")
                            .font(.headline)
                    }
                }
                .onAppear {
                    let fetchDescriptor = FetchDescriptor<Activity>()
                    if let activities = try? modelContext.fetch(fetchDescriptor) {
                        self.activity = activities.first
                    }
                }
                .padding()
    }
}

#Preview {
    Streak()
}
