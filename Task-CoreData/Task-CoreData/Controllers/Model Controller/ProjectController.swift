//
//  ProjectController.swift
//  Task-CoreData
//
//  Created by Omri Horowitz on 1/20/21.
//

import CoreData

class ProjectController {
    
//MARK: - SHARED INSTANCE
    static let shared = ProjectController()
    
//MARK: - SOURCE OF TRUTH
    var projects: [Project] = []
    
    private lazy var fetchRequest: NSFetchRequest<Project> = {
        let request = NSFetchRequest<Project>(entityName: "Project")
        request.predicate = NSPredicate(value: true)
        return request
    }()
    
//MARK: - CRUD
    func createProjectWith(name: String) {
        let newProject = Project(name: name)
        projects.append(newProject)
        CoreDataStack.saveContext()
    }
    
     func deleteProjectWith(project: Project) {
        guard let index = projects.firstIndex(of: project) else { return }
        projects.remove(at: index)
        CoreDataStack.context.delete(project)
        CoreDataStack.saveContext()
    }
}
