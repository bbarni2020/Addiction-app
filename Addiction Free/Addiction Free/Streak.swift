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
    let screenSize = UIScreen.main.bounds.width
    var body: some View {
        VStack {
                    if let daysSinceLastLog = activity?.daysSinceLastLog {
                        Text("You haven't failed for \(daysSinceLastLog) days.")
                            .padding(.all)
                            .frame(minWidth: screenSize * 0.93)
                            .font(.headline)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.primary, lineWidth: 2))
                            .shadow(color: Color.white.opacity(0.3), radius: 5, x: 0, y: 5)
                    } else {
                        Text("No addictions/logs recorded yet.")
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
