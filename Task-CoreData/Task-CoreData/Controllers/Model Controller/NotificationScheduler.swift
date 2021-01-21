//
//  NotificationScheduler.swift
//  Task-CoreData
//
//  Created by Omri Horowitz on 1/20/21.
//

import UserNotifications

class NotificationScheduler {
    
    func scheduleNotification(task: Task) {
        guard let dueDate = task.dueDate,
              let id = task.id else { return }
        
        //create the content for the notification
        let content = UNMutableNotificationContent()
        content.title = "Time to \(String(describing: task.name))."
        content.body = "Mark as done?"
        content.sound = .default
        
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: dueDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "\(id)", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Unable to add notification request: \(error.localizedDescription)")
            }
    }
}

    func cancelNotification(task: Task) {
        guard let id = task.id else { return }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
}
