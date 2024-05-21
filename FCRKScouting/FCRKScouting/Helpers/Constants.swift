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
            static let addPlayer = UIImage(systemName: "plus.circle")
            static let close = UIImage(systemName: "xmark.circle")
            static let related = UIImage(systemName: "personalhotspot.circle")
            static let features = UIImage(systemName: "star.circle")
            static let filters = UIImage(systemName: "magnifyingglass.circle")
            static let edit = UIImage(systemName: "pencil.circle")
            static let arrow = UIImage(systemName: "chevron.right")
        }
        enum TabBarIcons {
            static let updates = UIImage(systemName: "newspaper")
            static let search = UIImage(systemName: "binoculars.fill")
            static let profile = UIImage(systemName: "soccerball")
        }
    }
    // MARK: Fonts
    enum Fonts {
        static let title = UIFont(name: "Ostrovsky", size: 34)
        static let header = UIFont(name: "Ostrovsky", size: 21)
        static let normal = UIFont(name: "Ostrovsky", size: 16)
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
        static let post = "Должность:"
        static let notSpecified = "Не указана"
        static let access = "Доступ:"
        static let onlyRead = "Только чтение"
        static let editable = "Возможно редактирование"
        static let viewingPlan = "План просмотра"
        static let allReports = "Все отчёты"
        static let unknownUser = "Неизвестный пользователь"
        
        enum Placeholders {
            static let fullName = "Имя Фамилия"
            static let post = "Должность (необязательно)"
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
            static let yes = "Да"
            static let no = "Нет"
            static let continueAdding = "Продолжить добавление"
            static let continueEditing = "Продолжить редактирование"
            static let cancel = "Отменить"
            static let save = "Сохранить"
            static let next = "Далее"
            static let uploadPhoto = "Загрузить фото"
        }
        enum ScreenTitles {
            static let form = "Добро пожаловать!"
            static let updates = "Обновления"
            static let search = "Поиск"
            static let profile = "Профиль"
            static let addPlayer = "Добавить игрока"
            static let editPlayer = "Редактировать игрока"
            
        }
        enum Tips {
            static let title = "Справка:"
            static let related = "- Добавленное мной"
            static let features = "- Избранное"
            static let filters = "- Составные фильтры"
        }
        enum Alerts {
            static let emptyTextFields = (
                title: "Внимание",
                message: "Пожалуйста, заполните обязательные поля для ввода"
            )
            static let incorrectFullName = (
                title: "Внимание",
                message: """
                Пожалуйста, введите ваше имя и фамилию, и ничего лишнего
                """
            )
            static let wrongAccessKey = (
                title: "Не удалось войти",
                message: "Ключ доступа неверный"
            )
            static let notSelectedPosition = (
                title: "Внимание",
                message: "Пожалуйства, выберите позицию игрока"
            )
            static let exit = (
                title: "Выход",
                message: "Покинуть аккаунт?"
            )
        }
        enum ActionSheets {
            static let cancelAdding = """
            Вы уверены, что хотите отменить добавление нового игрока?
            """
            static let cancelEditing = """
            Вы уверены, что хотите отменить редактирование этого игрока?
            """
        }
        enum SegmentedControlItems {
            static let periodSegments = ["сегодня", "за неделю", "за месяц"]
            static let footSegments = ["правая", "левая"]
        }
        enum Positions: String, CaseIterable {
            case notSelected = "- не выбрано -"
            case goalkeeper = "Вратарь"
            case leftDefender = "Левый защитник"
            case rightDefender = "Правый защитник"
            case centerDefender = "Центральный защитник"
            case leftMidfielder = "Левый полузащитник"
            case rightMidfielder = "Правый полузащитник"
            case centerMidfielder = "Центральный полузащитник"
            case supportingMidfielder = "Опорный полузащитник"
            case attackingMidfielder = "Атакующий полузащитник"
            case forward = "Нападающий"
            
            func abbreviate() -> String {
                switch self {
                case .notSelected: ""
                case .goalkeeper: "ВР"
                case .leftDefender: "ЛЗ"
                case .rightDefender: "ПЗ"
                case .centerDefender: "ЦЗ"
                case .leftMidfielder: "ЛП"
                case .rightMidfielder: "ПП"
                case .centerMidfielder: "ЦП"
                case .supportingMidfielder: "ОП"
                case .attackingMidfielder: "АП"
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
