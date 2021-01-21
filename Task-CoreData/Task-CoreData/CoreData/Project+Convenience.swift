//
//  Project+Convenience.swift
//  Task-CoreData
//
//  Created by Omri Horowitz on 1/20/21.
//

import CoreData

extension Project {
    @discardableResult convenience init(name: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
    }
}
