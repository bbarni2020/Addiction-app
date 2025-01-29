//
//  Streak.swift
//  Streak
//
//  Created by ScriptKid on 2024. 10. 26..
//
import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(
            date: Date(),
            configuration: ConfigurationAppIntent(),
            daysSinceLastLog: 83
        )
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        let daysSinceLastLog = 22
        return SimpleEntry(
            date: Date(),
            configuration: configuration,
            daysSinceLastLog: daysSinceLastLog
        )
    }

    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        
        // Fetch the streak count from UserDefaults
        let sharedDefaults = UserDefaults(
            suiteName: "group.dev.masterbros.AddictionFree"
        )
        let lastLog = sharedDefaults?.object(forKey: "lastLog") as? Date
        var daysSinceLastLog = -1000
        if lastLog == nil {
            daysSinceLastLog = -1000
        } else {
            let calendar = Calendar.current
            let components = calendar.dateComponents(
                [.day],
                from: lastLog ?? Date(),
                to: Date()
            )
            daysSinceLastLog = components.day ?? -1000
        }

        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(
                byAdding: .hour,
                value: hourOffset,
                to: currentDate
            )!
            let entry = SimpleEntry(
                date: entryDate,
                configuration: configuration,
                daysSinceLastLog: daysSinceLastLog
            )
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let daysSinceLastLog: Int
}

struct StreakEntryView: View {
    var entry: Provider.Entry
    var body: some View {
        
        VStack(spacing: 8) {
            if entry.daysSinceLastLog == 0 {
                Text("0")
                    .font(.system(size: 39, weight: .bold))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                Text("Keep going!")
                    .font(.system(size: 21, weight: .bold))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.55)
                    .padding()
            } else if entry.daysSinceLastLog == -1000 {
                Text("Start building\nyour streak!")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.7)
                    .padding()
            } else {
                Image(systemName: "flame.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.yellow)
                    .padding(.top, 5)
                    .shadow(
                        color: .yellow.opacity(0.6),
                        radius: 5,
                        x: 0,
                        y: 0
                    )
                            
                Text("\(entry.daysSinceLastLog) days")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.gray)
                    .minimumScaleFactor(
                        0.3
                    ) // Scales text down in smaller widgets
                    .multilineTextAlignment(.center)
                            
                Text("🔥 Keep it going!")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.gray)
                    .minimumScaleFactor(0.5)
                    .padding(.bottom, 5)
            }
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: .infinity
        ) // Ensures full-size widget
        .padding(10) // Padding for text readability on small widgets
    }
}


struct Streak: Widget {
    let kind: String = "Streak"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(
            kind: kind,
            intent: ConfigurationAppIntent.self,
            provider: Provider()
        ) { entry in
            StreakEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}
