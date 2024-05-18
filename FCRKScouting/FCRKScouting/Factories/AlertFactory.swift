//
//  AlertFactory.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 08.04.2024.
//

import UIKit

struct AlertFactory {
    
    static func getWarningAlert(
        withTitle title: String,
        andMessage message: String
    ) -> UIAlertController {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(
            title: Constants.Text.ButtonTitles.ok,
            style: .cancel
        )
        alertController.addAction(alertAction)
        return alertController
    }
    
    static func getCancelAlert(
        withTitle title: String,
        andButtonTitle buttonTitle: String,
        completion: @escaping () -> Void
    ) -> UIAlertController {
        let alertController = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .actionSheet
        )
        alertController.setValue(
            NSAttributedString(
                string: title,
                attributes: [
                    .font: UIFont.systemFont(ofSize: 17, weight: .medium)
                ]
            ),
            forKey: "attributedTitle"
        )
        let cancelAction = UIAlertAction(
            title: Constants.Text.ButtonTitles.cancel,
            style: .destructive
        ) { _ in
                completion()
            }
        let continueAction = UIAlertAction(
            title: buttonTitle,
            style: .cancel
        )
        alertController.addAction(cancelAction)
        alertController.addAction(continueAction)
        return alertController
    }
    
    static func getExitAlert(
        completion: @escaping () -> Void
    ) -> UIAlertController {
        let alertController = UIAlertController(
            title: Constants.Text.Alerts.exit.title,
            message: Constants.Text.Alerts.exit.message,
            preferredStyle: .alert
        )
        let exitAction = UIAlertAction(
            title: Constants.Text.ButtonTitles.yes,
            style: .destructive) { _ in
                completion()
            }
        let cancelAction = UIAlertAction(
            title: Constants.Text.ButtonTitles.no,
            style: .cancel
        )
        alertController.addAction(exitAction)
        alertController.addAction(cancelAction)
        return alertController
    }
}
