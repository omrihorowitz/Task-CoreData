//
//  DateFormatterExtension.swift
//  Task-CoreData
//
//  Created by Omri Horowitz on 1/20/21.
//

import Foundation

extension DateFormatter {
    
    static let dueDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
}
