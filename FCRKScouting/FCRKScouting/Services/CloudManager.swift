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
    case fetchError(Error)
}

final class CloudManager {
    
    static let shared = CloudManager()
    
    private let id = "iCloud.RuslanShigapov.FCRKScouting.CloudKitContainer"
    
    private lazy var database = CKContainer(identifier: id).publicCloudDatabase
    
    private var records: [CKRecord] = []

    private init() {}
    
    private func prepareImageDataToSave(
        _ imageData: Data?,
        forPlayer player: Player
    ) -> (CKAsset?, URL?) {
        let imageFilePath = NSTemporaryDirectory() + (player.fullName ?? "")
        let imageURL = URL(fileURLWithPath: imageFilePath)
        guard let imageData else { return (nil, nil) }
        try? imageData.write(to: imageURL, options: .atomic)
        let imageAsset = CKAsset(fileURL: imageURL)
        return (imageAsset, imageURL)
    }
            
    func saveUserToCloud(_ user: User, completion: @escaping (String) -> Void) {
        let record = CKRecord(recordType: "CD_User")
        record.setValue(user.appleID, forKey: "CD_appleID")
        record.setValue(user.fullName, forKey: "CD_fullName")
        let isEditingAllowedValue: Int64 = user.isEditingAllowed ? 1 : 0
        record.setValue(isEditingAllowedValue, forKey: "CD_isEditingAllowed")
        database.save(record) { newRecord, error in
            if let newRecord {
                DispatchQueue.main.async {
                    completion(newRecord.recordID.recordName)
                }
            }
            if let error {
                print(error)
            }
        }
    }
    
    func savePlayerToCloud(
        _ player: Player,
        withImageData imageData: Data?,
        completion: @escaping (String) -> Void
    ) {
        let record = CKRecord(recordType: "CD_Player")
        record.setValue(player.fullName, forKey: "CD_fullName")
        let (asset, url) = prepareImageDataToSave(imageData, forPlayer: player)
        record.setValue(asset, forKey: "CD_photo")
        record.setValue(player.patronymic, forKey: "CD_patronymic")
        record.setValue(player.citizenship, forKey: "CD_citizenship")
        record.setValue(player.club, forKey: "CD_club")
        record.setValue(player.nationalTeam, forKey: "CD_nationalTeam")
        record.setValue(player.birthDate, forKey: "CD_birthDate")
        record.setValue(player.position, forKey: "CD_position")
        record.setValue(player.foot, forKey: "CD_foot")
        record.setValue(player.height, forKey: "CD_height")
        record.setValue(player.weight, forKey: "CD_weight")
        record.setValue(player.generalInfo, forKey: "CD_generalInfo")
        record.setValue(player.technique, forKey: "CD_technique")
        record.setValue(player.tactics, forKey: "CD_tactics")
        record.setValue(player.qualities, forKey: "CD_qualities")
        record.setValue(player.mental, forKey: "CD_mental")
        record.setValue(player.cost, forKey: "CD_cost")
        record.setValue(player.salary, forKey: "CD_salary")
        record.setValue(player.contractDate, forKey: "CD_contractDate")
        record.setValue(player.agentName, forKey: "CD_agentName")
        record.setValue(player.agentContacts, forKey: "CD_agentContacts")
        record.setValue(player.testingDate, forKey: "CD_testingDate")
        record.setValue(
            player.runningFor15MResult,
            forKey: "CD_runningFor15MResult")
        record.setValue(
            player.runningFor30MResult,
            forKey: "CD_runningFor30MResult")
        record.setValue(player.longJumpResult, forKey: "CD_longJumpResult")
        record.setValue(player.highJumpResult, forKey: "CD_highJumpResult")
        record.setValue(
            player.runningFor15MScore,
            forKey: "CD_runningFor15MScore")
        record.setValue(
            player.runningFor30MScore,
            forKey: "CD_runningFor30MScore")
        record.setValue(player.longJumpScore, forKey: "CD_longJumpScore")
        record.setValue(player.highJumpScore, forKey: "CD_highJumpScore")
        record.setValue(player.testingSummary, forKey: "CD_summary")
        record.setValue(player.lastEditor, forKey: "CD_lastEditor")
        record.setValue(player.updatedDate, forKey: "CD_updatedDate")
        record.setValue(player.creator, forKey: "CD_creator")
        database.save(record) { newRecord, _ in
            if let newRecord {
                completion(newRecord.recordID.recordName)
            }
            if let url {
                try? FileManager.default.removeItem(at: url)
            }
        }
    }
    
    func findUserFromCloud(
        byAppleID appleID: String,
        completion: @escaping (Result<CKRecord, Error>) -> Void
    ) {
        let predicate = NSPredicate(format: "CD_appleID == %@", appleID)
        let query = CKQuery(recordType: "CD_User", predicate: predicate)
        database.fetch(withQuery: query) { result in
            switch result {
            case .success((let matchResults, _)):
                guard let result = matchResults.first?.1 else {
                    completion(.failure(CloudError.recordNotFound))
                    return
                }
                completion(result)
            case .failure(let error):
                completion(.failure(CloudError.fetchError(error)))
            }
        }
    }
    
    func fetchPlayerFromCloud(completion: @escaping (CKRecord) -> Void) {
        let query = CKQuery(
            recordType: "CD_Player",
            predicate: NSPredicate(value: true))
        let queryOperation = CKQueryOperation(query: query)
//        queryOperation.desiredKeys = [
//            "CD_fullName",
//            "CD_patronymic",
//            "CD_citizenship",
//            "CD_club",
//            "CD_nationalTeam",
//            "CD_birthDate",
//            "CD_position",
//            "CD_foot",
//            "CD_height",
//            "CD_weight",
//            "CD_generalInfo",
//            "CD_technique",
//            "CD_tactics",
//            "CD_qualities",
//            "CD_mental",
//            "CD_cost",
//            "CD_salary",
//            "CD_contractDate",
//            "CD_agentName",
//            "CD_agentContacts",
//            "CD_testingDate",
//            "CD_runningFor15MResult",
//            "CD_runningFor30MResult",
//            "CD_longJumpResult",
//            "CD_highJumpResult",
//            "CD_runningFor15MScore",
//            "CD_runningFor30MScore",
//            "CD_longJumpScore",
//            "CD_highJumpScore",
//            "CD_summary",
//            "CD_lastEditor",
//            "CD_updatedDate",
//            "CD_creator"
//        ]
//        queryOperation.queuePriority = .veryHigh
        queryOperation.recordMatchedBlock = { [weak self] recordID, result in
            guard let self else { return }
            switch result {
            case .success(let record):
                records.append(record)
                completion(record)
            case .failure(_): return
            }
        }
        database.add(queryOperation)
//        database.fetch(withQuery: query) { result in
//            switch result {
//            case .success((let matchResults, _)):
//                var results: [Result<CKRecord, Error>] = []
//                matchResults.forEach { (_, record) in
//                    results.append(record)
//                }
//                completion(results)
//            case .failure(_):
//                completion([])
//            }
//        }
    }
    
//    func updateCloudData(forUser user: User) {
//        guard let recordName = user.recordName else { return }
//        let recordID = CKRecord.ID(recordName: recordName)
//        database.fetch(withRecordID: recordID) { [weak self] record, _ in
//            guard let self else { return }
//            if let record {
//                DispatchQueue.main.async { [weak self] in
//                    guard let self else { return }
//                    record.setValue(user.fullName, forKey: "CD_fullName")
//                    database.save(record) { _, _ in }
//                }
//            }
//        }
//    }
}
