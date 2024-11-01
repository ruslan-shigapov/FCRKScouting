//
//  Date+extension.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 28.10.2024.
//

import Foundation

extension Date {
    
    func format() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: self)
    }
}
