//
//  Constants.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 05.03.2024.
//

import UIKit

enum Constants {
    enum Images {
        static let logo = UIImage(named: "Logo")
    }
    
    enum Fonts {
        static let title = UIFont(name: "Futura", size: 35)
        static let header = UIFont(name: "Futura", size: 20) // ???
    }
    
    enum Text {
        static let appName = "FCRK SCOUTING"
        static let accessDescription = """
        Вход возможен только для сотрудников системы ФК \u{AB}Рубин\u{BB} Казань
        """
        
        enum Placeholder {
            static let firstName = "Имя"
            static let secondName = "Фамилия"
            static let accessKey = "Ключ доступа"
        }
    }
}
