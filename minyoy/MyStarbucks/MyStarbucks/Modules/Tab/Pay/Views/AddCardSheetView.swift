//
//  AddCardSheetView.swift
//  MyStarbucks
//
//  Created by 주민영 on 6/17/25.
//

import SwiftUI

struct AddCardSheetView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    @StateObject private var viewModel = CombineViewModel()
    
    var body: some View {
        VStack {
            VStack(spacing: 48) {
                Text("카드 등록")
                    .foregroundStyle(.black03)
                    .font(.pretendardBold(24))
                
                TextField("카드명 최대 20자", text: $viewModel.name)
                    .font(.pretendardMedium(16))
                    .foregroundStyle(.black)
                    .autocapitalization(.none)
                    .textInputAutocapitalization(.never)
                    .overlay(alignment: .bottom) {
                        Divider()
                            .frame(height: 1)
                            .background(Color.gray01)
                            .offset(x: 0, y: 9)
                    }
                    .onChange(of: viewModel.name) {
                        if viewModel.name.count > 20 {
                            viewModel.name = String(viewModel.name.prefix(20))
                        }
                    }
                
                TextField("카드 번호 12자 입력", text: $viewModel.num)
                    .font(.pretendardMedium(16))
                    .foregroundStyle(.black)
                    .keyboardType(.numberPad)
                    .overlay(alignment: .bottom) {
                        Divider()
                            .frame(height: 1)
                            .background(Color.gray01)
                            .offset(x: 0, y: 9)
                    }
                    .onChange(of: viewModel.num) {
                        viewModel.num = formatCardNumber(viewModel.num)
                        if viewModel.num.count > 14 {
                            viewModel.num = String(viewModel.num.prefix(14))
                        }
                    }
            }
            
            Button(action: {
                print("카드 이미지 생성하기")
                viewModel.startImageGeneration()
            }, label: {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .frame(height: 180)
                        .cornerRadius(10)
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(maxWidth: .infinity)
                        .frame(height: 180)
                        .foregroundStyle(.white01)
                        .overlay {
                            if (viewModel.isLoading) {
                                VStack {
                                    HStack {
                                        ProgressView()
                                            .frame(width: 30, height: 30)
                                        
                                        Text("이미지 생성 중..")
                                            .foregroundStyle(.gray04)
                                            .font(.pretendardRegular(17))
                                    }
                                    
                                    Text("\(formattedProgress(viewModel.progress))")
                                        .foregroundStyle(.gray05)
                                        .font(.pretendardMedium(16))
                                }
                            } else {
                                VStack(spacing: 15) {
                                    Image(systemName: "plus")
                                        .resizable()
                                        .fontWidth(.expanded)
                                        .frame(width: 36, height: 36)
                                        .foregroundStyle(.gray06)
                                    
                                    Text("카드 이미지 생성하기")
                                        .foregroundStyle(.gray05)
                                        .font(.pretendardMedium(16))
                                }
                            }
                        }
                }
            })
            .disabled(viewModel.isLoading)
            .padding(.top, 25)
            
            Spacer()
            
            Button(action: {
                print("카드 등록하기")
                viewModel.saveCard()
                dismiss()
            }, label: {
                Text("카드 등록하기")
                    .font(.pretendardMedium(16))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.green01)
                    )
            })
        }
        .padding(.top, 35)
        .padding(.horizontal, 33)
        .onAppear {
            viewModel.context = context
        }
    }
    
    /// 카드 번호 하이픈 추가하기
    func formatCardNumber(_ input: String) -> String {
        let digits = input.filter { $0.isNumber }
        let trimmed = String(digits.prefix(12))
        let parts = stride(from: 0, to: trimmed.count, by: 4).map {
            let start = trimmed.index(trimmed.startIndex, offsetBy: $0)
            let end = trimmed.index(start, offsetBy: min(4, trimmed.count - $0))
            return String(trimmed[start..<end])
        }
        return parts.joined(separator: "-")
    }
    
    /// 퍼센트 100곱하고 반올림
    func formattedProgress(_ value: Double?) -> String {
        guard let value else { return "0%" }
        
        let percent = Int((value * 100).rounded())
        return "\(percent)%"
    }
}

#Preview {
    AddCardSheetView()
}
