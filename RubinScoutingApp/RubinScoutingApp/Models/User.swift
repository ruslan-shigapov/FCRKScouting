//
//  User.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 11.03.2024.
//

struct User {
    var name: String
    var surname: String
    
    var post: String? = nil
    var access: AccessType = .readOnly
        
    var fullName: String {
        surname + " \(String(describing: name.first))."
    }
}

enum AccessType: String {
    case readOnly = "Только чтение"
    case editable = "Возможно редактирование"
}
