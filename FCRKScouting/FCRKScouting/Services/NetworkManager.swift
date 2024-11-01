//
//  NetworkManager.swift
//  FCRKScouting
//
//  Created by Ruslan Shigapov on 17.10.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case encodingFailure
    case unknown(_ error: Error)
    case invalidResponse
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func sendTask(
        withPlayers players: [Player],
        completion: @escaping (Result<Void, NetworkError>) -> Void
    ) {
        let path = "https://venkov.website/ap/mobapi.php"
        guard let url = URL(string: path) else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            let playersDTO = players.map { PlayerDTO.getPlayerDTO(from: $0) }
            let jsonData = try JSONEncoder().encode(playersDTO)
            request.httpBody = jsonData
        } catch {
            completion(.failure(.encodingFailure))
            return
        }
        URLSession.shared.dataTask(with: request) { _, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }
            if let error {
                completion(.failure(.unknown(error)))
                return
            }
            completion(.success(()))
        }.resume()
    }
}
