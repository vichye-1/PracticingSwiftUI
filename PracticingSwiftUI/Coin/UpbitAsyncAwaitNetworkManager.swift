//
//  UpbitAsyncAwaitNetworkManager.swift
//  PracticingSwiftUI
//
//  Created by 양승혜 on 9/11/24.
//

import Foundation

enum UpbitError: Error {
    case invalidURL
    case noData
    case decodingError
    case invalidResponse
}

class UpbitAsyncAwaitNetworkManager {
    static let shared = UpbitAsyncAwaitNetworkManager()
    
    static let url = URL(string: "https://api.upbit.com/v1/market/all")
    
    private init() { }
    
    func fetchUpbitAsyncAwait() async throws -> [Market] {
        guard let upbitUrl = UpbitAsyncAwaitNetworkManager.url else {
            throw UpbitError.invalidURL
        }
        let request = URLRequest(url: upbitUrl, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw UpbitError.invalidResponse
        }
        
        do {
            let markets = try JSONDecoder().decode([Market].self, from: data)
            return markets
        } catch {
            throw UpbitError.decodingError
        }
    }
}
