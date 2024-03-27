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
        
        enum TabBarIcon {
            static let updates = UIImage(systemName: "plus.circle")
            static let search = UIImage(systemName: "magnifyingglass.circle")
            static let profile = UIImage(systemName: "person.crop.circle")
        }
    }
    
    enum Fonts {
        static let title = UIFont(name: "Ostrovsky", size: 35)
        static let header = UIFont(name: "Ostrovsky", size: 20)
        static let normal = UIFont(name: "Ostrovsky", size: 15)
    }
    
    enum Text {
        static let appName = "FCRK SCOUTING"
        static let accessDescription = """
        Вход возможен только для сотрудников системы ФК \u{AB}Рубин\u{BB} Казань
        """
        static let access = "Доступ:"
        static let onlyRead = "Только чтение"
        static let editIsAllowed = "Возможно редактирование"
        
        enum Placeholder {
            static let fullName = "Имя Фамилия"
            static let accessKey = "Ключ доступа"
        }
        
        enum ButtonTitle {
            static let enter = "Войти"
            static let exit = "Выйти"
            static let ok = "OK"
        }
        
        enum ScreenTitle {
            static let updates = "Обновления"
            static let search = "Поиск"
            static let profile = "Профиль"
        }
        
        enum Alert {
            static let emptyTextField = (
                title: "Внимание",
                message: "Заполните все поля для ввода")
            static let incorrectFullName = (
                title: "Внимание",
                message: "Необходимо ввести имя, фамилию и нечего лишнего")
            static let wrongAccessKey = (
                title: "Не удалось войти",
                message: "Ключ доступа неверный")
            static let wrongSomething = (
                title: "Что-то пошло не так",
                message: "Перезапустите приложение")
        }
    }
}
