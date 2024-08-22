//
//  Activity.swift
//  Addiction Free
//
//  Created by MasterbrosDev, Barnabás on 21/08/2024.
//

import Foundation
import SwiftData

@Model class Activity {
    var name: String
    @Relationship(deleteRule: .cascade)
    var hexColor: String
    var statuses: [Status] = []
    init(name: String, hexColor: String = "FF0000") {
        self.name = name
        self.hexColor = hexColor
    }
}

extension Activity {
    @MainActor
    static var preview: ModelContainer {
        let container = try! ModelContainer(
            for: Activity.self,
            configurations: ModelConfiguration(
                isStoredInMemoryOnly: true
            )
        )
        return container
    }
}
