//
//  PayView.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/25/25.
//

import SwiftUI
import SwiftData

struct PayView: View {
    @Environment(\.modelContext) private var context
    
    @Query(sort: [SortDescriptor(\Card.createdAt, order: .reverse)]) private var cards: [Card]
    
    @State private var viewModel: PayViewModel = .init()
    @State private var showAddSheet = false
    
    var body: some View {
        VStack {
            topView
                .padding(.vertical, 25)
                .padding(.horizontal, 23)
            
            if cards.isEmpty {
                VStack {
                    Text("등록된 카드가 없습니다.")
                        .foregroundStyle(.gray06)
                        .font(.pretendardSemiBold(18))
                    
                    Spacer()
                }
            } else {
                VStack(spacing: 23) {
                    VStack {
                        CustomCarousel(config: .init(hasOpacity: true, hasScale: true, cardWidth: 275, minimumCardWidth: 235), selection: $viewModel.activeID, data: cards) { item in
                            Image(uiImage: UIImage(data: item.image) ?? UIImage())
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        }
                        .frame(height: 145)
                    }
                    
                    infoView(info: viewModel.activeCard ?? Card(name: "카드 A", price: 9999, num: "1234-1234-1234", image: UIImage(named: "Card1") ?? UIImage()))
                    
                    Spacer()
                }
            }
        }
        .onAppear {
            viewModel.context = context
        }
        .onChange(of: viewModel.activeID) {
            viewModel.updateActiveCard(cards: cards)
        }
        .onChange(of: cards) {
            viewModel.updateActiveCard(cards: cards)
        }
        .sheet(isPresented: $showAddSheet) {
            AddCardSheetView()
                .presentationDragIndicator(.visible)
        }
    }
    
    private var topView: some View {
        HStack {
            Text("Pay")
                .foregroundStyle(.black)
                .font(.pretendardBold(24))
            
            Spacer()
            
            Button(action: {
                print("추가")
                showAddSheet = true
            }, label: {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(.black)
            })
        }
    }
    
    private func infoView(info: Card) -> some View {
        VStack(spacing: 23) {
            VStack(spacing: 5) {
                Text(info.name)
                    .foregroundStyle(.gray06)
                    .font(.pretendardMedium(13))
                
                Text("\(info.price)원")
                    .foregroundStyle(.black)
                    .font(.pretendardSemiBold(18))
            }
            
            VStack(spacing: 5) {
                Text(maskedCardNumber(info.num))
                    .foregroundStyle(.gray06)
                    .font(.pretendardRegular(12))
                
                if (viewModel.timeRemaining == 0) {
                    Text("카드 유효시간이 만료되었습니다")
                        .foregroundStyle(.gray04)
                        .font(.pretendardRegular(12))
                } else {
                    HStack {
                        Text("카드 유효 시간")
                            .foregroundStyle(.gray04)
                            .font(.pretendardRegular(12))

                        Text(viewModel.formattedTime)
                            .foregroundStyle(.green02)
                            .font(.pretendardRegular(12))
                    }
                }
            }
        }
    }
    
    /// ****-****-1234 형식으로 반환하는 함수
    func maskedCardNumber(_ number: String) -> String {
        let digitsOnly = number.replacingOccurrences(of: "-", with: "")
        guard digitsOnly.count == 12 else { return number }

        let maskedPrefix = String(repeating: "*", count: 8)
        let suffix = digitsOnly.suffix(4)
        let masked = maskedPrefix + suffix

        let chunks = stride(from: 0, to: masked.count, by: 4).map {
            masked.dropFirst($0).prefix(4)
        }
        return chunks.joined(separator: "-")
    }
}

#Preview {
    PayView()
}
