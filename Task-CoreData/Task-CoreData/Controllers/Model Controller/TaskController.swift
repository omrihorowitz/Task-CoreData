//
//  TaskController.swift
//  Task-CoreData
//
//  Created by Omri Horowitz on 1/19/21.
//

import CoreData

class TaskController {
    
    static let shared = TaskController()
    let notificationScheduler = NotificationScheduler()
    
    var sections: [[Task]] { [notCompletedTasks, completedTasks]}
    var notCompletedTasks: [Task] = []
    var completedTasks: [Task] = []
    
    private lazy var fetchRequest: NSFetchRequest<Task> = {
        let request = NSFetchRequest<Task>(entityName: "Task")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
    func createTaskWith(name: String, notes: String?, dueDate: Date?) {
        let task = Task(name: name, notes: notes, dueDate: dueDate)
        notCompletedTasks.append(task)
        CoreDataStack.saveContext()
        notificationScheduler.scheduleNotification(task: task)
    }
    
    func fetchTasks() {
        let tasks = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
        completedTasks = tasks.filter({$0.isComplete})
        notCompletedTasks = tasks.filter({!$0.isComplete})
    }
    
    func update(task: Task, name: String, notes: String?, dueDate: Date?) {
        task.name = name
        task.dueDate = dueDate
        CoreDataStack.saveContext()
        notificationScheduler.cancelNotification(task: task)
        notificationScheduler.scheduleNotification(task: task)
    }
    
    func toggleIsComplete(task: Task) {
            task.isComplete.toggle()
            if let taskToToggle = notCompletedTasks.firstIndex(of: task) {
                notCompletedTasks.remove(at: taskToToggle)
                completedTasks.append(task)
            } else if let taskToToggle = completedTasks.firstIndex(of: task) {
                completedTasks.remove(at: taskToToggle)
                notCompletedTasks.append(task)
            }
            CoreDataStack.saveContext()
        }
    
    func deleteTask(taskToDelete: Task) {
        if let index = notCompletedTasks.firstIndex(of: taskToDelete) {
            notCompletedTasks.remove(at: index)
        } else if let index = completedTasks.firstIndex(of: taskToDelete) {
            completedTasks.remove(at: index)
        }
        CoreDataStack.context.delete(taskToDelete)
        notificationScheduler.cancelNotification(task: taskToDelete)
        CoreDataStack.saveContext()
    }
}
