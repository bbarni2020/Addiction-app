//
//  CalendarView.swift
//  Addiction Free
//
//  Created by MasterbrosDev, Barnabás on 22/08/2024.
//

import SwiftUI

import SwiftUI
import SwiftData

struct CalendarView: View {
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
        
        VStack {
            HStack {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .fontWeight(.black)
                        .foregroundStyle(Color.primary)
                        .frame(maxWidth: .infinity)
                }
            }
            LazyVGrid(columns: columns) {
                ForEach(days, id: \.self) { day in
                    if day.monthInt == date.monthInt {
                        Text(day.formatted(.dateTime.day()))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.primary)
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(
                                Circle()
                                    .foregroundStyle(
                                        day.isToday ? .red.opacity(counts[day.dayInt] != nil ? 0.8 : 0.3)
                                                    : color.opacity(counts[day.dayInt] != nil ? 0.8 : 0.3)
                                    )
                            )
                            .overlay(alignment: .bottomTrailing) {
                                if let count = counts[day.dayInt] {
                                    Image(systemName: count <= 50 ? "\(count).circle.fill" : "plus.circle.fill")
                                        .foregroundColor(Color.primary)
                                        .imageScale(.medium)
                                        .background(
                                            Color(.systemBackground)
                                                .clipShape(Circle())
                                        )
                                        .offset(x: 5, y: 5)
                                }
                            }
                    } else {
                        Text("")
                    }
                }
            }
        }
        .padding()
        .onAppear {
            loadCalendarDays()
            setupCounts()
        }
        .onChange(of: date) { _ in
            loadCalendarDays()
            setupCounts()
        }
        .onChange(of: selectedActivity) { _ in
            setupCounts()
        }
    }
    
    private func loadCalendarDays() {
        days = date.calendarDisplayDays
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
