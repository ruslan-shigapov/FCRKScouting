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
        static let photoPlaceholder = UIImage(systemName: "person.circle")
        
        enum ButtonImages {
            static let edit = UIImage(systemName: "square.and.pencil")
            static let addPlayer = UIImage(systemName: "person.badge.plus")
            static let filters = UIImage(
                systemName: "slider.horizontal.2.square.on.square")
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
        static let header = UIFont(name: "Ostrovsky", size: 22)
        static let normal = UIFont(name: "Ostrovsky", size: 15)
        static let text = UIFont.systemFont(ofSize: 16, weight: .light)
        static let floatingLabel = UIFont.systemFont(ofSize: 12, weight: .light)
        static let whiteLabel = UIFont.systemFont(ofSize: 17, weight: .semibold)
        static let description = UIFont.systemFont(ofSize: 12, weight: .thin)
    }
    // MARK: Text
    enum Text {
        static let appName = "FCRK SCOUTING"
        static let accessDescription = """
        Вход возможен только для сотрудников системы ФК \u{AB}Рубин\u{BB} Казань
        """
        static let birthDate = "Дата рождения:"
        static let foot = "Рабочая нога:"
        static let position = "Позиция:"
        static let access = "Доступ:"
        static let onlyRead = "Только чтение"
        static let editIsAllowed = "Возможно редактирование"
        static let unknownUser = "Неизвестный пользователь"
        
        enum Placeholders {
            static let fullName = "Имя Фамилия"
            static let accessKey = "Ключ доступа"
            static let patronymic = "Отчество (необязательно)"
            static let citizenship = "Гражданство"
            static let club = "Клуб"
            static let nationalTeam = "Сборная (необязательно)"
        }
        enum ButtonTitles {
            static let enter = "Войти"
            static let exit = "Выйти"
            static let ok = "OK"
            static let cancel = "Отмена"
            static let yes = "Да"
            static let no = "Нет"
            static let cancelAdding = "Отменить добавление"
            static let continueAdding = "Продолжить добавление"
            static let saveAdding = "Сохранить"
            static let uploadPhoto = "Загрузить фото"
        }
        enum ScreenTitles {
            static let updates = "Обновления"
            static let search = "Поиск"
            static let profile = "Профиль"
            static let addPlayer = "Добавить игрока"
        }
        enum Alerts {
            static let emptyTextField = (
                title: "Внимание",
                message: "Заполните все обязательные поля для ввода")
            static let incorrectFullName = (
                title: "Внимание",
                message: "Необходимо ввести имя и фамилию")
            static let wrongAccessKey = (
                title: "Не удалось войти",
                message: "Ключ доступа неверный")
            static let wrongSomething = (
                title: "Что-то пошло не так",
                message: "Перезапустите приложение")
            static let notSelectedPosition = (
                title: "Внимание",
                message: "Выберите позицию игрока")
            static let exit = (
                title: "Выход",
                message: "Покинуть аккаунт?")
            static let playerAdding = "Добавить нового игрока?"
        }
        enum ActionSheets {
            static let edit = "Изменить"
            static let cancelAdding = """
            Вы уверены, что хотите отменить добавление нового игрока?
            """
        }
        enum SegmentedControlItems {
            static let timeSegments = ["неделя", "месяц", "год"]
            static let leagueSegments = ["все", "ЮФЛ-1", "ЮФЛ-2", "ЮФЛ-3"]
            static let footSegments = ["правая", "левая"]
        }
        
        enum Positions: String, CaseIterable {
            case notSelected = "- не выбрано -"
            case goalkeeper = "Вратарь"
            case leftDefender = "Левый защитник"
            case rightDefender = "Правый защитник"
            case centerDefender = "Центральный защитник"
            case leftMidfield = "Левый полузащитник"
            case rightMidfield = "Правый полузащитник"
            case centerMidfield = "Центральный полузащитник"
            case forward = "Нападающий"
        }
        
        enum TextViewTitles {
            static let generalInfo = "Общая информация:"
            static let technique = "Техника:"
            static let tactics = "Тактика:"
            static let qualities = "Физ. качества:"
            static let mental = "Ментальность:"
        }
    }
}
