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
            .refreshable {
                fetchMarketAsyncAwait()
            }
            .navigationTitle("Search")
            .searchable(text: $searchKeyword, prompt: "Search")
        }
        .task {
            fetchMarketAsyncAwait()
        }
    }
    
    func fetchMarket() {
        UpbitNetwork.fetchMarket { result in
            switch result {
            case .success(let coinData):
                self.markets = coinData
            case .failure(let failure):
                print("error! \(failure)")
            }
        }
    }
    
    func fetchMarketAsyncAwait() {
        Task {
            do {
                let markets = try await UpbitAsyncAwaitNetworkManager.shared.fetchUpbitAsyncAwait()
                self.markets = markets
            } catch {
                print("error: \(error)")
            }
        }
    }
    
    // MARK: - $item, item 언제 써야하는지
    func listView() -> some View {
        LazyVStack {
            ForEach($markets, id: \.id) { $item in
                if filteredMarketInfo.contains(where: { $0.id == item.id }) {
                    NavigationLink {
                        NavigationLazyView(CoinDetailView(market: item))
                    } label: {
                        CoinRowView(item: $item)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
    
}

struct CoinRowView: View {
    @Binding var item: Market
    
    var body: some View {
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
            Button(action: {
                item.like.toggle()
            }, label: {
                Image(systemName: item.like ? "star.fill" : "star")
                    .padding(.trailing, 16)
            })
        }
    }
}

struct NavigationLazyView<Content: View>: View {
    
    let build: () -> Content
    
    var body: some View {
        build()
    }
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
        print("navigationLazyView Init")
    }
}

#Preview {
    CoinSearchView()
}
