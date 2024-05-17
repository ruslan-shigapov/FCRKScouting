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
            static let refresh = UIImage(systemName: "arrow.clockwise.circle")
            static let addPlayer = UIImage(
                systemName: "person.crop.circle.badge.plus"
            )
            static let close = UIImage(systemName: "xmark.circle")
            static let filters = UIImage(systemName: "binoculars.circle")
            static let edit = UIImage(systemName: "pencil.circle")
        }
        enum TabBarIcons {
            static let updates = UIImage(systemName: "plus.circle")
            static let search = UIImage(systemName: "magnifyingglass.circle")
            static let profile = UIImage(systemName: "person.crop.circle")
        }
    }
    // MARK: Fonts
    enum Fonts {
        static let title = UIFont(name: "Ostrovsky", size: 34)
        static let header = UIFont(name: "Ostrovsky", size: 22)
        static let normal = UIFont(name: "Ostrovsky", size: 17)
        static let text = UIFont.systemFont(ofSize: 17, weight: .light)
        static let description = UIFont.systemFont(ofSize: 13, weight: .thin)
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
        static let access = "Уровень доступа:"
        static let onlyRead = "Только чтение"
        static let editable = "Возможно редактирование"
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
                message: "Заполните все обязательные поля для ввода"
            )
            static let incorrectFullName = (
                title: "Внимание",
                message: "Необходимо ввести имя и фамилию"
            )
            static let wrongAccessKey = (
                title: "Не удалось войти",
                message: "Ключ доступа неверный"
            )
            static let wrongSomething = (
                title: "Что-то пошло не так",
                message: "Перезапустите приложение"
            )
            static let notSelectedPosition = (
                title: "Внимание",
                message: "Выберите позицию игрока"
            )
            static let exit = (
                title: "Выход",
                message: "Покинуть аккаунт?"
            )
        }
        enum ActionSheets {
            static let edit = "Изменить"
            static let cancelAdding = """
            Вы уверены, что хотите отменить добавление нового игрока?
            """
        }
        enum SegmentedControlItems {
            static let periodSegments = ["сегодня", "за неделю", "за месяц"]
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
            
            func abbreviate() -> String {
                switch self {
                case .notSelected: ""
                case .goalkeeper: "ВР"
                case .leftDefender: "ЛЗ"
                case .rightDefender: "ПЗ"
                case .centerDefender: "ЦЗ"
                case .leftMidfield: "ЛП"
                case .rightMidfield: "ПП"
                case .centerMidfield: "ЦП"
                case .forward: "НП"
                }
            }
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
