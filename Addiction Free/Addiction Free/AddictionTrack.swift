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
        Button("Add Smoke Status") {
            addSmokeWorkout()
        }
        .padding()
        .navigationTitle("Add Status")
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
        print("Sucess")
    }
}


#Preview {
    AddictionTrack()
}
