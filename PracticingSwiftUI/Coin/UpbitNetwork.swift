//
//  UpbitNetwork.swift
//  PracticingSwiftUI
//
//  Created by 양승혜 on 9/4/24.
//

import Foundation

enum UpbitAPIError: Error {
    case invalidURL
    case noData
    case decodingError
}

struct UpbitNetwork {
    private init() { }
    
    static func fetchMarket(completion: @escaping (Result<[Market], Error>) -> Void) {
        guard let url = URL(string: "https://api.upbit.com/v1/market/all") else {
            completion(.failure(UpbitAPIError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(UpbitAPIError.noData))
                }
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode([Market].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(UpbitAPIError.decodingError))
                }
            }
        }.resume()
    }
}
