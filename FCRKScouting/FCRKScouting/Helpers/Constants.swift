//
//  Constants.swift
//  RubinScoutingApp
//
//  Created by Ruslan Shigapov on 05.03.2024.
//

import UIKit

enum Constants {
    // MARK: Colors
    enum Colors {
        static let deepGreen = UIColor(named: "DeepGreen")
        static let naturalGold = UIColor(named: "NaturalGold")
    }
    // MARK: Images
    enum Images {
        static let logo = UIImage(named: "Logo")
        static let photoPlaceholder = UIImage(systemName: "person.circle")

        enum TabBarIcons {
            static let updates = UIImage(systemName: "newspaper")
            static let search = UIImage(systemName: "binoculars.fill")
            static let profile = UIImage(systemName: "soccerball")
        }
        enum ButtonImages {
            static let refresh = UIImage(systemName: "arrow.clockwise.circle")
            static let add = UIImage(systemName: "plus.circle")
            static let delete = UIImage(systemName: "trash.circle")
            static let close = UIImage(systemName: "xmark.circle")
            static let plus = UIImage(systemName: "plus.square")
            static let minus = UIImage(systemName: "minus.square")
            static let features = UIImage(systemName: "star.circle")
            static let related = UIImage(systemName: "personalhotspot.circle")
            static let filters = UIImage(systemName: "magnifyingglass.circle")
            static let edit = UIImage(systemName: "pencil.circle")
            static let arrow = UIImage(systemName: "chevron.right")
        }
    }
    // MARK: Fonts
    enum Fonts {
        static let title = UIFont(name: "Ostrovsky", size: 34)
        static let header = UIFont(name: "Ostrovsky", size: 21)
        static let normal = UIFont(name: "Ostrovsky", size: 16)
        static let text = UIFont.systemFont(ofSize: 16, weight: .light)
        static let secondary = UIFont.systemFont(ofSize: 13, weight: .thin)
        static let description = UIFont.systemFont(ofSize: 10, weight: .thin)
    }
    // MARK: Text
    enum Text {
        static let appName = "FCRK Scouting"
        static let transferDetails = "Трансферные детали"
        static let testingDetails = "Тестирование"
        static let statisticsDetails = "Статистика"
        static let notSpecified = "Не указана"
        static let onlyRead = "Только чтение"
        static let editable = "Возможно редактирование"

        enum Titles {
            static let birthDate = "Дата рождения:"
            static let position = "Позиция:"
            static let foot = "Рабочая нога:"
            static let height = "Рост:"
            static let weight = "Вес:"
            static let cost = "Стоимость перехода:"
            static let salary = "Зарплата игрока:"
            static let contract = "Окончание контракта:"
            static let age = "Возраст:"
            static let citizenship = "Гражданство:"
            static let clubAndNationalTeam = "Клуб/сборная:"
            static let date = "Дата:"
            static let normative = "Нормативы:"
            static let runningFor15M = "Бег на 15м"
            static let runningFor30M = "Бег на 30м"
            static let longJump = "Прыжок с места"
            static let highJump = "Прыжок в высоту"
            static let score = "оценка:"
            static let summary = "Выводы:"
            static let access = "Доступ:"
        }
        enum Descriptions {
            static let access = """
            Доступ предоставляется исключительно сотрудникам системы ФК \"Рубин\" Казань
            """
            static let signIn = """
            Вход с помощью Apple ID необходим для совместного пользования приложением
            """
            static let pageSlider = """
            Поля в этом слайдере необязательные, любые данные можно добавить или изменить позже
            """
            static let forGoalkeepers = "(для вратарей)"
        }
        enum Placeholders {
            static let accessKey = "Ключ доступа*"
            static let fullName = "Имя Фамилия*"
            static let patronymic = "Отчество"
            static let citizenship = "Гражданство*"
            static let club = "Клуб*"
            static let nationalTeam = "Сборная"
            static let agentName = "Агент"
            static let contacts = "Контакты"
            static let startTyping = "Начните вводить"
        }
        enum ButtonTitles {
            static let ok = "OK"
            static let cancel = "Отменить"
            static let continueAdding = "Продолжить добавление"
            static let continueEditing = "Продолжить редактирование"
            static let uploadPhoto = "Загрузить фото"
            static let editPhoto = "Изменить фото"
            static let choosePhoto = "Выбрать из библиотеки"
            static let deletePhoto = "Убрать фото"
            static let save = "Сохранить"
            static let back = "Назад"
            static let no = "Нет"
            static let yes = "Да"
            static let exit = "Выйти"
            static let viewingPlan = "План просмотра"
            static let allReports = "Все отчёты"
        }
        enum ScreenTitles {
            static let greeting = "Добро пожаловать!"
            static let form = "Личные данные"
            static let updates = "Обновления"
            static let addPlayer = "Добавить игрока"
            static let editPlayer = "Редактировать игрока"
            static let career = "Движение по футбольной вертикали"
            static let search = "Поиск"
            static let filters = "Дополнительные фильтры"
            static let profile = "Профиль"
        }
        enum Tips {
            static let title = "Справка:"
            static let features = "- Избранное"
            static let related = "- Добавленное мной"
            static let filters = "- Доп. фильтры"
        }
        enum Alerts {
            static let wrongAccessKey = (
                title: "Не удалось войти",
                message: "Пожалуйста, введите действительный ключ доступа"
            )
            static let authError = (
                title: "Ошибка авторизации",
                message: "Пожалуйста, попробуйте еще раз"
            )
            static let emptyTextFields = (
                title: "Внимание",
                message: "Пожалуйста, заполните обязательные поля для ввода"
            )
            static let incorrectFullName = (
                title: "Внимание",
                message: """
                Пожалуйста, введите имя и фамилию, и ничего лишнего
                """
            )
            static let invalidChars = (
                title: "Внимание",
                message: """
                Допустимы только символы кириллицы в имени и фамилии
                """
            )
            static let notSelectedPosition = (
                title: "Внимание",
                message: "Пожалуйста, выберите позицию игрока"
            )
            static let exit = (
                title: "Покинуть профиль?",
                message: ""
            )
            static let delete = (
                title: "Удалить этого игрока?",
                message: ""
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
            case centralDefender = "Центральный защитник"
            case leftMidfielder = "Левый полузащитник"
            case rightMidfielder = "Правый полузащитник"
            case centralMidfielder = "Центральный полузащитник"
            case supportingMidfielder = "Опорный полузащитник"
            case attackingMidfielder = "Атакующий полузащитник"
            case forward = "Нападающий"
            
            func abbreviate() -> String {
                switch self {
                case .notSelected: ""
                case .goalkeeper: "\"ВР\""
                case .leftDefender: "\"ЛЗ\""
                case .rightDefender: "\"ПЗ\""
                case .centralDefender: "\"ЦЗ\""
                case .leftMidfielder: "\"ЛП\""
                case .rightMidfielder: "\"ПП\""
                case .centralMidfielder: "\"ЦП\""
                case .supportingMidfielder: "\"ОП\""
                case .attackingMidfielder: "\"АП\""
                case .forward: "\"НП\""
                }
            }
        }
        enum TextViewTitles {
            static let generalInfo = "Общ. информация:"
            static let technique = "Техника:"
            static let tactics = "Тактика:"
            static let qualities = "Физ. качества:"
            static let mental = "Ментальность:"
        }
    }
}
