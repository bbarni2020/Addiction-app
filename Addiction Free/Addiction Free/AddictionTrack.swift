//
//  AddictionTrack.swift
//  Addiction Free
//
//  Created by MasterbrosDev, Barnabás on 21/08/2024.
//

import SwiftUI
import SwiftData

struct AddictionTrack: View {
    @Environment(\.modelContext) private var modelContext
    var body: some View {
        VStack{
            HStack{
                Button() {
                } label: {
                    Text("I'm still okay")
                                .foregroundColor(.white)
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                }
                .background(Color.green.opacity(0.8))
                .cornerRadius(12)
                .shadow(color: Color.primary.opacity(0.3), radius: 5, x: 0, y: 5)
                .padding([.top, .leading, .bottom])
                Button() {
                    addSmokeWorkout()
                } label: {
                    Text("I failed")
                                .foregroundColor(.white)
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                }
                .background(Color.red.opacity(0.8))
                .cornerRadius(12)
                .shadow(color: Color.primary.opacity(0.3), radius: 5, x: 0, y: 5)
                .padding([.top, .bottom, .trailing])
            }
        }
    }

    func addSmokeWorkout() {
        let fetchDescriptor = FetchDescriptor<Activity>(
            predicate: #Predicate { $0.name == "Smoke" }
        )
        

        let activities = try? modelContext.fetch(fetchDescriptor)
        let smokeActivity: Activity

        if let activity = activities?.first {
            smokeActivity = activity
        } else {
            smokeActivity = Activity(name: "Smoke", hexColor: "000000")
            modelContext.insert(smokeActivity)
        }

        let newStatus = Status(date: Date())
        smokeActivity.statuses.append(newStatus)

        try? modelContext.save()
    }
}


#Preview {
    AddictionTrack()
}
