//
//  Task+Convenience.swift
//  Task-CoreData
//
//  Created by Omri Horowitz on 1/19/21.
//

import CoreData

extension Task {
    @discardableResult convenience init(name: String, notes: String?, dueDate: Date?, id: String = UUID().uuidString, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.notes = notes
        self.dueDate = dueDate
        self.id = id
    }
    
    func add(taskWithName name: String, notes: String?, dueDate: Date?) {
        
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        
    }
    
    func remove(task: Task) {
        
    }
    
    func fetchTasks(){
        
    }
}
