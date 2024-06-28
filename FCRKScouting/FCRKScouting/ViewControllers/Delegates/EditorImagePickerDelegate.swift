//
//  EditorImagePickerDelegate.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 27.06.2024.
//

import UIKit

final class EditorImagePickerDelegate: NSObject,
                                       UIImagePickerControllerDelegate,
                                       UINavigationControllerDelegate {
    
    private var viewModel: EditorViewModelProtocol
    private var wasImagePicked: ((UIImage?) -> Void)?
    
    init(viewModel: EditorViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [
            UIImagePickerController.InfoKey : Any
        ]
    ) {
        if let pickedImage = info[
            UIImagePickerController.InfoKey.originalImage
        ] as? UIImage {
            viewModel.selectedPhoto = pickedImage
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        viewModel.selectedPhoto = nil
        picker.dismiss(animated: true)
    }
}
