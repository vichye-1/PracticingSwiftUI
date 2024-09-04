//
//  Market.swift
//  PracticingSwiftUI
//
//  Created by 양승혜 on 9/4/24.
//

import Foundation

struct Market: Decodable, Hashable {
    let market, koreanName, englishName: String
    
    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
}
