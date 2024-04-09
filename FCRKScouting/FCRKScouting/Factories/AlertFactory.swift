//
//  AlertFactory.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 08.04.2024.
//

import UIKit

struct AlertFactory {
    
    static func getAlert(
        withTitle title: String,
        andMessage message: String
    ) -> UIAlertController {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        let alertAction = UIAlertAction(
            title: Constants.Text.ButtonTitles.ok,
            style: .cancel)
        alertController.addAction(alertAction)
        return alertController
    }
    
    static func getCancelAlert(
        withTitle title: String,
        completion: @escaping () -> Void
    ) -> UIAlertController {
        let alertController = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .actionSheet)
        alertController.setValue(
            NSAttributedString(
                string: title,
                attributes: [
                    .font: UIFont.systemFont(ofSize: 16, weight: .medium)
                ]),
            forKey: "attributedTitle")
        let cancelAction = UIAlertAction(
            title: Constants.Text.ButtonTitles.cancelAdding,
            style: .destructive) { _ in
                completion()
            }
        let continueAction = UIAlertAction(
            title: Constants.Text.ButtonTitles.continueAdding,
            style: .cancel)
        alertController.addAction(cancelAction)
        alertController.addAction(continueAction)
        return alertController
    }
    
    static func getEditAlert(withTitle title: String) -> UIAlertController {
        let alertController = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .actionSheet)
        alertController.setValue(
            NSAttributedString(
                string: title,
                attributes: [
                    .font: UIFont.systemFont(ofSize: 18, weight: .medium)
                ]),
            forKey: "attributedTitle")
        let editPhoto = UIAlertAction(
            title: "Фотографию",
            style: .default)
        let editFullName = UIAlertAction(
            title: "Имя и фамилию",
            style: .default)
        
        // TODO: finish with actions
        
        let cancelAction = UIAlertAction(
            title: Constants.Text.ButtonTitles.cancel,
            style: .cancel)
        alertController.addAction(editPhoto)
        alertController.addAction(editFullName)
        alertController.addAction(cancelAction)
        return alertController
    }
    
    static func getExitAlert(
        completion: @escaping () -> Void
    ) -> UIAlertController {
        let alertController = UIAlertController(
            title: Constants.Text.Alerts.exit.title,
            message: Constants.Text.Alerts.exit.message,
            preferredStyle: .alert)
        let allowAction = UIAlertAction(
            title: Constants.Text.ButtonTitles.yes,
            style: .default) { _ in
                completion()
            }
        let cancelAction = UIAlertAction(
            title: Constants.Text.ButtonTitles.no,
            style: .cancel)
        alertController.addAction(allowAction)
        alertController.addAction(cancelAction)
        return alertController
    }
}
