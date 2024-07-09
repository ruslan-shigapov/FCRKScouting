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
            preferredStyle: .alert)
        let alertAction = UIAlertAction(
            title: Constants.Text.ButtonTitles.ok,
            style: .cancel)
        alertAction.holdLinkColor()
        alertController.addAction(alertAction)
        return alertController
    }
    
    static func getUploadPhotoActionSheet(
        isPhotoUploaded: Bool,
        chooseCompletion: @escaping () -> Void,
        deleteCompletion: @escaping () -> Void
    ) -> UIAlertController {
        let alertController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(
            title: Constants.Text.ButtonTitles.cancel,
            style: .cancel)
        let chooseAction = UIAlertAction(
            title: Constants.Text.ButtonTitles.choosePhoto,
            style: .default) { _ in
                chooseCompletion()
            }
        let deleteAction = UIAlertAction(
            title: Constants.Text.ButtonTitles.deletePhoto,
            style: .destructive) { _ in
                deleteCompletion()
            }
        cancelAction.holdLinkColor()
        chooseAction.holdLinkColor()
        alertController.addAction(cancelAction)
        alertController.addAction(chooseAction)
        if isPhotoUploaded {
            alertController.addAction(deleteAction)
        }
        return alertController
    }
    
    static func getCancelActionSheet(
        withTitle title: String,
        andButtonTitle buttonTitle: String,
        completion: @escaping () -> Void
    ) -> UIAlertController {
        let alertController = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .actionSheet)
        alertController.setValue(
            NSAttributedString(
                string: title,
                attributes: [.font: Constants.Fonts.text]),
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
            style: .cancel)
        continueAction.holdLinkColor()
        alertController.addAction(cancelAction)
        alertController.addAction(continueAction)
        return alertController
    }
    
    static func getConfirmationAlert(
        withTitle title: String,
        andMessage message: String,
        completion: @escaping () -> Void
    ) -> UIAlertController {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        let exitAction = UIAlertAction(
            title: Constants.Text.ButtonTitles.yes,
            style: .destructive) { _ in
                completion()
            }
        let cancelAction = UIAlertAction(
            title: Constants.Text.ButtonTitles.no,
            style: .cancel)
        cancelAction.holdLinkColor()
        alertController.addAction(exitAction)
        alertController.addAction(cancelAction)
        return alertController
    }
}
