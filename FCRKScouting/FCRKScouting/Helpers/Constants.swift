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
            static let favoritesOff = UIImage(systemName: "star")
            static let favoritesOn = UIImage(systemName: "star.fill")
            static let favorites = UIImage(systemName: "star.circle")
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
        static let notSpecified1 = "Не указана"
        static let notSpecified2 = "Не указано"
        static let noSearchResults = "Поиск не дал результатов"
        static let noIntervalResults = "За этот период игроков не найдено"
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
            static let agent = "Агент:"
            static let contacts = "Контакты:"
            static let date = "Дата:"
            static let normative = "Нормативы:"
            static let runningFor15M = "Бег на 15м"
            static let runningFor30M = "Бег на 30м"
            static let longJump = "Прыжок с места"
            static let highJump = "Прыжок в высоту"
            static let score = "оценка:"
            static let summary = "Выводы:"
            static let actualTest = "Результаты тестирования:"
            static let fullName = "ФИО:"
            static let career = "Карьера:"
            static let year = "Год:"
            static let dash = "--"
            static let period = "Период:"
            static let league = "Лига:"
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
            static let fullName = """
            Для консистентности данных, рекомендуется использовать только символы кириллицы
            """
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
            static let coach = "Тренер"
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
            static let apply = "Применить"
            static let reset = "Сбросить"
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
            static let extraInfo = "Дополнительная информация"
            static let search = "Поиск"
            static let filters = "Дополнительные фильтры"
            static let profile = "Профиль"
        }
        enum Tips {
            static let title = "Справка:"
            static let favorites = "- Избранное"
            static let related = "- Добавленное мной"
            static let filters = "- Доп. фильтры"
        }
        enum Alerts {
            static let wrongAccessKey = (
                title: "Не удалось войти",
                message: "Пожалуйста, введите действительный ключ доступа"
            )
            static let wrongSomething = (
                title: "Что-то пошло не так",
                message: "Пожалуйста, проверьте подключение"
            )
            static let authError = (
                title: "Не удалось авторизоваться",
                message: "Пожалуйста, попробуйте еще раз"
            )
            static let emptyTextFields = (
                title: "Внимание",
                message: "Пожалуйста, заполните обязательные поля для ввода"
            )
            static let suchPlayerExists = (
                title: "Не удалось сохранить",
                message: "Игрок с таким именем и фамилией уже существует"
            )
            static let incorrectFullName = (
                title: "Внимание",
                message: """
                Пожалуйста, введите имя и фамилию, и ничего лишнего
                """
            )
            static let notSelectedPosition = (
                title: "Внимание",
                message: "Пожалуйста, выберите позицию игрока"
            )
            static let wrongRatioOfYears = (
                title: "Внимание",
                message: "Неправильное соотношение годов"
            )
            static let wrongRatioOfAges = (
                title: "Внимание",
                message: "Неправильное соотношение возрастов"
            )
            static let repeatedYears = (
                title: "Внимание",
                message: """
            За этот период уже есть запись, сначала удалите ее, если необходимо
            """
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
        enum Leagues: String, CaseIterable {
            case notSelected = "- не выбрано -"
            case stageOne = "1 этап Академии"
            case stageTwo = "2 этап Академии"
            case stageThree = "3 этап Академии"
            case stageFour = "4 этап Академии"
            case uflOne = "ЮФЛ-1"
            case uflTwo = "ЮФЛ-2"
            case uflThree = "ЮФЛ-3"
            case youngTeam = "Рубин-М"
            case reserveTeam = "Рубин-2"
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
