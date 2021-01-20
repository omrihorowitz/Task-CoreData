//
//  TaskDetailViewController.swift
//  Task-CoreData
//
//  Created by Omri Horowitz on 1/19/21.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    var task: Task?
    var date: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = taskNameTextField.text, !name.isEmpty else { return }
        guard let notes = taskNotesTextView.text, !notes.isEmpty else { return }
        
        if let task = task {
            TaskController.shared.update(task: task, name: name, notes: notes, dueDate: taskDueDatePicker.date)
        } else {
            TaskController.shared.createTaskWith(name: name, notes: notes, dueDate: taskDueDatePicker.date)
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        date = taskDueDatePicker.date
    }
    
    func updateViews() {
        guard let task = task else { return }
        taskNameTextField.text = task.name
        taskNotesTextView.text = task.notes
        taskDueDatePicker.date = task.dueDate ?? Date()
    }
    
}
