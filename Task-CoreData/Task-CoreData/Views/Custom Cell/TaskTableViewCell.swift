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
        nameLabel.text = task.name
        if task.isComplete {
            completionButton.setBackgroundImage(UIImage(systemName: "checkmark.square"), for: .normal)
        } else {
            completionButton.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
        }
    }
}
