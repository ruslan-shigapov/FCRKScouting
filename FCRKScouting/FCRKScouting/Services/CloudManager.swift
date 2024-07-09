//
//  CloudManager.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 08.07.2024.
//

import CloudKit
import UIKit

enum CloudError: Error {
    case recordNotFound
}

final class CloudManager {
    
    static let shared = CloudManager()
    
    private let id = "iCloud.RuslanShigapov.FCRKScouting.CloudKitContainer"
    
    private lazy var database = CKContainer(identifier: id).publicCloudDatabase
    
    private var records: [CKRecord] = []

    private init() {}
    
    private func prepareImageToSave(
        player: Player,
        image: UIImage
    ) -> (CKAsset?, URL?) {
        let scale = image.size.width > 1080 ? 1080 / image.size.width : 1
        guard let pngData = image.pngData() else { return (nil, nil) }
        let scaleImage = UIImage(data: pngData, scale: scale)
        let imageFilePath = NSTemporaryDirectory() + (player.fullName ?? "")
        let imageURL = URL(fileURLWithPath: imageFilePath)
        guard let jpegData = scaleImage?.jpegData(compressionQuality: 1) else {
            return (nil, nil)
        }
        try? jpegData.write(to: imageURL, options: .atomic)
        let imageAsset = CKAsset(fileURL: imageURL)
        return (imageAsset, imageURL)
    }
    
    private func deleteTempImage(imageURL: URL) {
        try? FileManager.default.removeItem(at: imageURL)
    }
        
    func saveDataToCloud(
        forUser user: User,
        completion: @escaping (String) -> Void
    ) {
        let record = CKRecord(recordType: "CD_User")
        record.setValue(user.appleID, forKey: "CD_appleID")
        record.setValue(user.fullName, forKey: "CD_fullName")
        let isEditingAllowedValue: Int64 = user.isEditingAllowed ? 1 : 0
        record.setValue(isEditingAllowedValue, forKey: "CD_isEditingAllowed")
        database.save(record) { newRecord, _ in
            if let newRecord {
                completion(newRecord.recordID.recordName)
            }
        }
    }
    
    func findUserFromCloud(
        byAppleID appleID: String,
        completion: @escaping (Result<CKRecord, Error>) -> Void
    ) {
        let predicate = NSPredicate(format: "CD_appleID == %@", appleID)
        let query = CKQuery(recordType: "CD_User", predicate: predicate)
        database.fetch(withQuery: query){ result in
            switch result {
            case .success((let matchResults, _)):
                guard let result = matchResults.first?.1 else {
                    completion(.failure(CloudError.recordNotFound))
                    return
                }
                completion(result)
            case .failure(_): 
                return
            }
        }
    }
    
    func updateCloudData(forUser user: User) {
        guard let recordName = user.recordName else { return }
        let recordID = CKRecord.ID(recordName: recordName)
        database.fetch(withRecordID: recordID) { record, _ in
            if let record {
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    record.setValue(user.fullName, forKey: "CD_fullName")
                    database.save(record) { _, _ in }
                }
            }
        }
    }
}
