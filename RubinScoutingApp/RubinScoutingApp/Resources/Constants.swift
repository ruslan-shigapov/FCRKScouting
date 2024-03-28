//
//  Constants.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 05.03.2024.
//

import UIKit

enum Constants {
    // MARK: Images
    enum Images {
        static let logo = UIImage(named: "Logo")
        
        enum ButtonImages {
            static let edit = UIImage(systemName: "highlighter")
            static let addPlayer = UIImage(systemName: "person.badge.plus")
            static let filters = UIImage(
                systemName: "slider.horizontal.2.square")
        }
        enum TabBarIcons {
            static let updates = UIImage(systemName: "plus.circle")
            static let search = UIImage(systemName: "magnifyingglass.circle")
            static let profile = UIImage(systemName: "person.crop.circle")
        }
    }
    // MARK: Fonts
    enum Fonts {
        static let title = UIFont(name: "Ostrovsky", size: 35)
        static let header = UIFont(name: "Ostrovsky", size: 20)
        static let normal = UIFont(name: "Ostrovsky", size: 15)
    }
    // MARK: Text
    enum Text {
        static let appName = "FCRK SCOUTING"
        static let accessDescription = """
        Вход возможен только для сотрудников системы ФК \u{AB}Рубин\u{BB} Казань
        """
        static let access = "Доступ:"
        static let onlyRead = "Только чтение"
        static let editIsAllowed = "Возможно редактирование"
        static let edit = "Изменить"
        static let addNewPlayer = "Добавить нового игрока?"
        
        enum Placeholders {
            static let fullName = "Имя Фамилия"
            static let accessKey = "Ключ доступа"
        }
        enum ButtonTitles {
            static let enter = "Войти"
            static let exit = "Выйти"
            static let ok = "OK"
            static let yes = "Да"
            static let no = "Нет"
        }
        enum ScreenTitles {
            static let updates = "Обновления"
            static let search = "Поиск"
            static let profile = "Профиль"
        }
        enum Alerts {
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
            static let exit = (
                title: "Выход",
                message: "Покинуть аккаунт?")
        }
    }
}
