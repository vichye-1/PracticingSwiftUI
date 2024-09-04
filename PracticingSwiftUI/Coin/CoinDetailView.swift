//
//  CoinDetailView.swift
//  PracticingSwiftUI
//
//  Created by 양승혜 on 9/4/24.
//

import SwiftUI

struct CoinDetailView: View {
    
    let market: Market
    
    var body: some View {
        NavigationView {
            HStack {
                VStack {
                    Text(market.koreanName)
                    Text(market.englishName)
                    Text(market.market)
                }
                Spacer()
                
                Image(systemName: market.like ? "star.fill": "star")
            }
                .navigationTitle("Market Details")
                .navigationBarTitleDisplayMode(.inline)
        }
           
        
    }
}
