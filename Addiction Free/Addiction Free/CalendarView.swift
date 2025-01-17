//
//  CalendarView.swift
//  Addiction Free
//
//  Created by MasterbrosDev, Barnabás on 22/08/2024.
//

import SwiftUI

import SwiftUI
import SwiftData

struct DeviceChecker {
    
    private func getDeviceIdentifier() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.compactMap { element in
            element.value as? Int8
        }.map { element in
            String(UnicodeScalar(UInt8(element)))
        }.joined()
        return identifier
    }
    
    func isDeviceSE2orSE3() -> Bool {
        let deviceIdentifier = getDeviceIdentifier()
        let se2Identifier = "iPhone12,8"
        let se3Identifier = "iPhone14,6"
        
        return deviceIdentifier == se2Identifier || deviceIdentifier == se3Identifier
    }
}

struct CalendarView: View {
    let deviceChecker = DeviceChecker()
    let date: Date
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    @State private var days: [Date] = []
    let selectedActivity: Activity?
    @Query private var statuses: [Status]
    @State private var counts: [Int : Int] = [:]
    
    init(date: Date, selectedActivity: Activity?) {
        self.date = date
        self.selectedActivity = selectedActivity
        
        let endOfMonthAdjustment = Calendar.current.date(byAdding: .day, value: 1, to: date.endOfMonth)!
        let predicate = #Predicate<Status> {
            $0.date >= date.startOfMonth && $0.date < endOfMonthAdjustment
        }
        _statuses = Query(filter: predicate, sort: \Status.date)
    }
    
    var body: some View {
        let color = Color.green
    }
    
    private func setupCounts() {
        var filteredStatuses = statuses
        if let selectedActivity {
            filteredStatuses = statuses.filter { $0.activity == selectedActivity }
        }
        counts = Dictionary(filteredStatuses.map { ($0.date.dayInt, 1) }, uniquingKeysWith: +)
    }
}

#Preview {
    CalendarView(date: Date(), selectedActivity: nil)
        .modelContainer(Activity.preview)
}
