import Foundation
import SwiftUICore
import UserNotifications

class NotificationManager {
    @Environment(\.modelContext) private var modelContext
    @State private var activity: Activity?
    private let notificationsEnabledKey = "isNotificationsEnabled"
    
    private var isNotificationsEnabled: Bool {
        get {
            return UserDefaults.standard.bool(forKey: notificationsEnabledKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: notificationsEnabledKey)
        }
    }
    
    private let quotes = [
        "Every step away from addiction is a step closer to freedom.",
        "The power to change lies within you.",
        "Small wins add up to big victories.",
        "You're stronger than you think.",
        "Every day without addiction is a triumph.",
        "Progress is progress, no matter how small.",
        "Focus on the future, not the past.",
        "Your strength today is your success tomorrow.",
        "One day at a time, you're winning.",
        "Believe in the person you're becoming.",
        "Keep pushing forward, you're doing great.",
        "The journey is tough, but so are you.",
        "Recovery is a journey, not a destination.",
        "Today is another chance to get it right.",
        "Your future is worth fighting for.",
        "Stay strong, your progress is showing.",
        "You’re proving your strength every day.",
        "Don't look back, you're not going that way.",
        "Celebrate every small victory.",
        "Log your progress in the app to keep the momentum going.",
        "Recovery is not a race, it's a journey. Take it one step at a time.",
        "Every challenge is an opportunity to grow stronger.",
        "You are capable of amazing things, believe in your potential.",
        "Small victories lead to big accomplishments. Keep going.",
        "Strength doesn’t come from what you can do, it comes from overcoming what you thought you couldn’t.",
        "Your future is created by what you do today, not tomorrow.",
        "The greatest battles we fight are the ones within ourselves.",
        "You’re stronger than you know, braver than you believe, and more capable than you can imagine.",
        "It’s never too late to be what you might have been.",
        "Don’t let the struggles of today ruin the strength of tomorrow.",
        "Focus on progress, not perfection. Every step forward matters.",
        "Courage doesn’t always roar; sometimes, it’s the quiet voice that says, ‘I’ll try again tomorrow.’",
        "Success is the sum of small efforts repeated day in and day out.",
        "One day at a time is all you need to focus on.",
        "The moment you want to quit is the moment you need to keep pushing.",
        "Recovery is hard, but regret is harder. Choose progress.",
        "Your story isn't over yet, you are still writing your success.",
        "Progress may be slow, but it’s still progress. Keep moving.",
        "You are not your past. You are the hero of your own future.",
        "Success starts with the decision to try. You're already winning.",
        "Healing is messy, but it’s a beautiful process. Trust the journey.",
        "A stumble does not mean you’ve fallen. Get back up stronger.",
        "Don't count the days, make the days count toward your freedom.",
        "You are enough just as you are, and more than capable of growth.",
        "Your hardest times often lead to the greatest moments of your life.",
        "In the middle of difficulty lies opportunity. Keep pushing forward.",
        "Each day without a relapse is a victory worth celebrating.",
        "Nothing changes if nothing changes. Take that first step today.",
        "The only way out is through. You’re closer to the other side than you think.",
        "Keep going, because you didn’t come this far just to come this far.",
        "The road to recovery is tough, but every mile makes you stronger.",
        "Your journey is unique, don’t compare it to anyone else’s story.",
        "Progress requires patience. Be kind to yourself on the journey.",
        "You’re doing better than you think. Celebrate the small wins.",
        "Every setback is a setup for a greater comeback.",
        "Remember why you started and let that drive you forward.",
        "Even the smallest steps in the right direction can be the biggest moments.",
        "You have the power to create the life you want. Keep fighting for it.",
        "The pain you feel today will be the strength you feel tomorrow.",
        "Rise up from your struggles; your strength grows with each challenge.",
        "Believe in the person you're becoming. You've got this.",
        "One day, all your hard work will pay off. Stay the course.",
        "You are not alone in this journey. Keep moving, keep growing.",
        "Challenges are what make life interesting; overcoming them is what makes life meaningful.",
        "You’ve survived 100% of your hardest days. Keep going.",
        "One positive thought in the morning can change your whole day.",
        "You are more resilient than you think. Trust your strength.",
        "Success doesn’t come from what you do occasionally; it comes from what you do consistently.",
        "Healing takes time. Don’t rush the process, trust it."
    ]
    
    init() {
        UNUserNotificationCenter
            .current()
            .requestAuthorization(options: [.alert, .sound, .badge]) {
                [weak self] granted,
                _ in
                self?.isNotificationsEnabled = granted
                if granted {
                    self?.turnOnNotifications()
                } else {
                    self?.turnOffNotifications()
                }
            }
    }
    
    func turnOnNotifications() {
        guard isNotificationsEnabled else { return }
        
        // Schedule hourly quote notifications
        for hour in 9...19 {
            scheduleHourlyQuoteNotification(at: hour)
        }
        
        // Schedule streak update + daily check-in notification
        scheduleDailyStreakUpdateAndNotification()
        
        isNotificationsEnabled = true
    }
    
    func turnOffNotifications() {
        UNUserNotificationCenter
            .current()
            .removeAllPendingNotificationRequests()
        isNotificationsEnabled = false
    }
    
    func areNotificationsTurnedOn() -> Bool {
        return isNotificationsEnabled
    }
    
    private func scheduleHourlyQuoteNotification(at hour: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Log your progress in the app!"
        content.body = quotes.randomElement() ?? "Keep it up!"
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )
        let request = UNNotificationRequest(
            identifier: "AddictionNotification_\(hour)",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    // Schedule the daily streak notification and update the streak just before sending the notification
    private func scheduleDailyStreakUpdateAndNotification() {
        let streakUpdateTime: DateComponents = {
            var components = DateComponents()
            components.hour = 20
            components.minute = 28 // Schedule just before the daily notification (20:30)
            return components
        }()
        
        // Schedule the streak update (runs 1 minute before daily check-in notification)
        let streakUpdateTrigger = UNCalendarNotificationTrigger(
            dateMatching: streakUpdateTime,
            repeats: true
        )
        let streakUpdateRequest = UNNotificationRequest(
            identifier: "StreakUpdate",
            content: UNMutableNotificationContent(),
            trigger: streakUpdateTrigger
        )
        
        UNUserNotificationCenter
            .current()
            .add(streakUpdateRequest) { [weak self] _ in
                // When triggered, update the streak count and schedule the streak notification
                self?.updateStreakCount()
                self?.scheduleDailyCheckInNotification()
            }
    }
    
    // Simulate streak count update (replace this with actual logic to update streak)
    private func updateStreakCount() {
        // Fetch the streak count from UserDefaults
        let sharedDefaults = UserDefaults(
            suiteName: "group.dev.masterbros.AddictionFree"
        )
        let lastLog = sharedDefaults?.object(forKey: "lastLog") as? Date
        var daysSinceLastLogg = -1000
        if lastLog == nil {
            daysSinceLastLogg = -1000
        } else {
            let calendar = Calendar.current
            let componentse = calendar.dateComponents(
                [.day],
                from: lastLog ?? Date(),
                to: Date()
            )
            daysSinceLastLogg = componentse.day ?? -1000
        }
        UserDefaults.standard.set(daysSinceLastLogg, forKey: "streak")
    }
    
    private func scheduleDailyCheckInNotification() {
        let streak = UserDefaults.standard.integer(forKey: "streak")
        let content = UNMutableNotificationContent()
        content.title = "Streak Report"
        
        if streak < 0 {
            content.body = "Start logging your activity to build a streak!"
        } else if streak == 0 {
            content.body = "You have no streak yet. Come back tomorrow, and keep going!"
        } else {
            content.body = "You haven't failed for \(streak) days."
        }
        
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 20
        dateComponents.minute = 30
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )
        let request = UNNotificationRequest(
            identifier: "DailyStreakNotification",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print(
                    "Failed to schedule notification: \(error.localizedDescription)"
                )
            }
        }
    }
}
