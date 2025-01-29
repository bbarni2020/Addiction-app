//
//  StreakDataFetcher.swift
//  Addiction Free
//
//  Created by ScriptKid on 2024. 10. 27..
//

import Foundation
import SwiftData

class StreakDataFetcher {
    func getDaysSinceLastLog() -> Int? {
        let sharedDefaults = UserDefaults(suiteName: "group.dev.masterbros.AddictionFree")
        guard let lastDate = sharedDefaults?.object(forKey: "lastLog") as? Date else {
                return nil
            }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: lastDate, to: Date())
        return components.day
    }
}
