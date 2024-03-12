//
//  User.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 11.03.2024.
//

struct User {
    var firstName: String
    var secondName: String
    var post: String?
        
    var fullName: String {
        secondName + " \(String(describing: firstName.first))."
    }
    
    var isEditingAllowed: Bool {
        false // TEMPORARY
    }
}
