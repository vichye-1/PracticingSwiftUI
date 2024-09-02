//
//  ContentView.swift
//  PracticingSwiftUI
//
//  Created by 양승혜 on 9/2/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image("launch")
                Spacer()
                Image("launchImage")
                Spacer()
                
                NavigationLink(destination: MBTIView()) {
                    Text("시작하기")
                        .asBottomButton()
                        
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
