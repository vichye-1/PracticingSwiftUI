//
//  RandomImageView.swift
//  PracticingSwiftUI
//
//  Created by 양승혜 on 9/5/24.
//

import SwiftUI

struct RandomImageView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    titleStyle("First Section")
                        .padding(.top, 20)
                    titleStyle("Second Section")
                    titleStyle("Third Section")
                    titleStyle("Forth Section")
                    
                    .navigationTitle("My Random Image")
                }
            }
        }
    }
    
    func titleStyle(_ title: String) -> some View {
        VStack {
            Text(title)
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)

            ScrollView(.horizontal) {
                HStack(){
                    Spacer(minLength: 10)
                    ForEach(0..<10) { item in
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(.blue)
                            .frame(width: 100, height: 150)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    RandomImageView()
}
