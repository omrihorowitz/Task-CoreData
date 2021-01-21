//
//  ProjectListViewController.swift
//  Task-CoreData
//
//  Created by Omri Horowitz on 1/20/21.
//

import UIKit

class ProjectListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    //MARK: - Outlets

    @IBOutlet weak var projectNameTextField: UITextField!
    @IBOutlet weak var projectListTableView: UITableView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        projectListTableView.dataSource = self
        projectListTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TaskController.shared.fetchTasks()
        projectListTableView.reloadData()
    }
    
    //MARK: - Actions
    @IBAction func createProjectButtonTapped(_ sender: Any) {
        guard let projectName = projectNameTextField.text, !projectName.isEmpty else { return }
        ProjectController.shared.createProjectWith(name: projectName)
        projectListTableView.reloadData()
    }
    
    //MARK: - Navigation
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProjectController.shared.projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath)
        
        cell.textLabel?.text = ProjectController.shared.projects[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let projectToDelete = ProjectController.shared.projects[indexPath.row]
            ProjectController.shared.deleteProjectWith(project: projectToDelete)
            projectListTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProjectDetails" {
            guard let indexPath = projectListTableView.indexPathForSelectedRow,
                  let destination = segue.destination as? TaskListTableViewController else { return }
            let projectToSend = ProjectController.shared.projects[indexPath.row]
            destination.project = projectToSend
        }
    }
}
