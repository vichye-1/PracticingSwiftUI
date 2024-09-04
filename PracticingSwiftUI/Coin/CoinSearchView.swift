//
//  CoinSearchView.swift
//  PracticingSwiftUI
//
//  Created by 양승혜 on 9/3/24.
//

import SwiftUI

struct CoinSearchView: View {
    
    @State private var markets: [Market] = []
    @State private var searchKeyword = ""
    
    var filteredMarketInfo: [Market] {
        return searchKeyword.isEmpty ? markets : markets.filter { $0.koreanName.contains(searchKeyword) || $0.market.contains(searchKeyword) }
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                listView()
            }
            .navigationTitle("Search")
            .searchable(text: $searchKeyword, prompt: "Search")
        }
        .task {
            UpbitNetwork.fetchMarket { result in
                switch result {
                case .success(let coinData):
                    self.markets = coinData
                case .failure(let failure):
                    print("error! \(failure)")
                }
            }
        }
    }
    
    func listView() -> some View {
        LazyVStack {
            ForEach(filteredMarketInfo, id: \.self) { item in
                    rowView(item)
            }
        }
    }

    func rowView(_ item: Market) -> some View {
        HStack(spacing: 20){
            Image(systemName: "bitcoinsign.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .padding(.leading, 16)
                
            VStack(alignment: .leading) {
                Text(item.koreanName)
                    .font(.title3)
                    .bold()
                Text(item.market)
                    .font(.callout)
                    .foregroundStyle(.gray)
            }
            Spacer()
            Image(systemName: "star")
                .padding(.trailing, 16)
        }
    }
}

#Preview {
    CoinSearchView()
}
