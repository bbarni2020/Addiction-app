//
//  Status.swift
//  Addiction Free
//
//  Created by ScriptKid on 21/08/2024.
//

import Foundation
import SwiftData

@Model
class Status {
    var date: Date
    var activity: Activity?
    
    init(date: Date) {
        self.date = date
    }
}
