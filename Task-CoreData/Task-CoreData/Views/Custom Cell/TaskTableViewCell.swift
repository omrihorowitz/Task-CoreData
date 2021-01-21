//
//  TaskTableViewCell.swift
//  Task-CoreData
//
//  Created by Omri Horowitz on 1/19/21.
//

import UIKit

protocol TaskListTableViewDelegate: AnyObject {
    func buttonTapped(_ sender: TaskTableViewCell)
}

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    weak var delegate: TaskListTableViewDelegate?
    
    
    @IBAction func completionButtonTapped(_ sender: Any) {
        delegate?.buttonTapped(self)
        }
    
    func updateViews() {
        guard let task = task else { return }
        let dueDateFormatted = DateFormatter.dueDate.string(from: task.dueDate ?? Date())
        nameLabel.text = task.name
        if task.isComplete {
            dueDateLabel.text = "Completed by: \(dueDateFormatted)"
            completionButton.setBackgroundImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            dueDateLabel.text = "Complete by: \(dueDateFormatted)"
            completionButton.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
        }
    }
}
