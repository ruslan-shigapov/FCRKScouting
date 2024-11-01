//
//  AlertFactory.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 08.04.2024.
//

import UIKit

struct AlertFactory {
    
    static func getAlertController(
        withTitle title: String,
        andMessage message: String,
        completion: (() -> Void)? = nil
    ) -> UIAlertController {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        if let completion {
            let exitAction = UIAlertAction(
                title: Constants.Texts.ButtonTitles.yes,
                style: .destructive
            ) { _ in
                completion()
            }
            let cancelAction = UIAlertAction(
                title: Constants.Texts.ButtonTitles.no,
                style: .cancel)
            alertController.addAction(exitAction)
            alertController.addAction(cancelAction)
        } else {
            let alertAction = UIAlertAction(
                title: Constants.Texts.ButtonTitles.ok,
                style: .cancel)
            alertController.addAction(alertAction)
        }
        return alertController
    }
    
    static func getUploadPhotoActionSheet(
        hasPhotoAlreadyBeenUploaded: Bool,
        selectionCompletion: @escaping () -> Void,
        deletingCompletion: @escaping () -> Void
    ) -> UIAlertController {
        let alertController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(
            title: Constants.Texts.ButtonTitles.cancel,
            style: .cancel)
        let chooseAction = UIAlertAction(
            title: Constants.Texts.ButtonTitles.choosePhoto,
            style: .default
        ) { _ in
            selectionCompletion()
        }
        let deleteAction = UIAlertAction(
            title: Constants.Texts.ButtonTitles.deletePhoto,
            style: .destructive
        ) { _ in
            deletingCompletion()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(chooseAction)
        if hasPhotoAlreadyBeenUploaded {
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
            title: Constants.Texts.ButtonTitles.cancel,
            style: .destructive
        ) { _ in
            completion()
        }
        let continueAction = UIAlertAction(
            title: buttonTitle,
            style: .cancel)
        alertController.addAction(cancelAction)
        alertController.addAction(continueAction)
        return alertController
    }
}
