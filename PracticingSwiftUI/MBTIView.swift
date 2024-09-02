//
//  MBTIView.swift
//  PracticingSwiftUI
//
//  Created by 양승혜 on 9/2/24.
//

import SwiftUI

struct MBTIView: View {
    
    @State private var nickname = ""
    @State private var isSheetPresented = false
    @State private var selectedMBTI = [-1, -1, -1, -1]
    
    let mbtiOptions = [
        ["E", "I"],
        ["S", "N"],
        ["T", "F"],
        ["J", "P"]
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                profileButton()
                
                TextField("닉네임을 입력해주세요 :)", text: $nickname)
                    .padding(.horizontal)
                
                Divider()
                    .frame(height: 1)
                    .padding(.horizontal, 16)
                
                HStack(spacing: 20) {
                    Spacer()
                    Text("MBTI")
                        .bold()
                        .font(.title3)
                
                    Spacer()
                    
                    ForEach(0..<mbtiOptions.count, id: \.self) { columnIndex in
                        VStack {
                            ForEach(0..<mbtiOptions[columnIndex].count, id: \.self) { rowIndex in
                                Button(action: {
                                    selectedMBTI[columnIndex] = rowIndex
                                }) {
                                    Text(mbtiOptions[columnIndex][rowIndex])
                                        .frame(minWidth: 40, minHeight: 40)
                                        .background(selectedMBTI[columnIndex] == rowIndex ? .gray : .white)
                                        .foregroundStyle(selectedMBTI[columnIndex] == rowIndex ? .white : .gray)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(.gray, lineWidth: 1))
                                }
                            }
                        }
                    }
                    Spacer()
                }
                
                Spacer()
                
                completeButton()
                
            }
            .sheet(isPresented: $isSheetPresented, content: {
                AssignView()
            })
            .navigationTitle("PROFILE SETTING")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func profileButton() -> some View{
        Button(action: {
            
        }, label: {
            Image("profile_1")
                .resizable()
                .frame(width: 120, height: 120)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.blue, lineWidth: 5))
        })
    }
    
    private func completeButton() -> some View {
        Button("완료") {
            isSheetPresented.toggle()
        }
        .asBottomButton()
    }
    
}

#Preview {
    MBTIView()
}
