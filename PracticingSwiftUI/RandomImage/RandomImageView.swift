//
//  RandomImageView.swift
//  PracticingSwiftUI
//
//  Created by 양승혜 on 9/5/24.
//

import SwiftUI

struct RandomImageView: View {
    
    private let sectionTitle: [String] = ["First Section", "Second Section", "Third Section", "Forth Section"]
    private let randomNumber: [Int] = (0..<4).map { _ in Int.random(in: 1...1000) }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0..<4) { item in
                        SectionStyle(sectionTitle[item], number: randomNumber[item])
                            .padding(.top, 16)
                    }
                    .navigationTitle("My Random Image")
                }
            }
        }
    }
    
    func SectionStyle(_ title: String, number: Int) -> some View {
        VStack {
            Text(title)
                .font(.title2)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)

            randomImageView(number)
        }
    }
}

func randomImageView(_ randomNumber: Int) -> some View {
    ScrollView(.horizontal, showsIndicators: false) {
        HStack(){
            Spacer(minLength: 10)
            ForEach(0..<10) { item in
                AsyncImage(url: URL(string: "https://picsum.photos/id/\(randomNumber + item)/200/300")) { image in
                    image
                        .resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 25.0))
            }
        }
    }
}

#Preview {
    RandomImageView()
}
