//
//  ReceiptView.swift
//  MyStarbucks
//
//  Created by 주민영 on 4/6/25.
//

import SwiftUI
import PhotosUI
import SwiftData

struct ReceiptView: View {
    @Environment(NavigationRouter.self) private var router
    @Environment(\.modelContext) private var context
    
    @Query(sort: \ReceiptsModel.createdAt) private var receipts: [ReceiptsModel]
    
    @State private var viewModel: OCRViewModel = .init()
    
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var showCamera = false
    @State private var showActionSheet = false
    @State private var showPhotosPicker = false
    
    var body: some View {
        VStack {
            navBar
            
            topContentView
            
            bottomContentView
        }
        .background(Color.white01)
        .navigationTitle("")
        .navigationBarHidden(true)
        .confirmationDialog("사진을 어떻게 추가할까요?", isPresented: $showActionSheet, titleVisibility: .visible) {
            Button("앨범에서 가져오기") {
                showPhotosPicker = true
            }

            Button("카메라로 촬영하기") {
                showCamera = true
            }

            Button("취소", role: .cancel) {}
        }
        .sheet(isPresented: $showCamera) {
            CameraPicker { image in
                viewModel.addImage(image)
            }
        }
        .photosPicker(isPresented: $showPhotosPicker, selection: $selectedItems, maxSelectionCount: 5, matching: .images)
        .onChange(of: selectedItems) { oldItems, newItems in
            for item in newItems {
                Task {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        viewModel.addImage(image)
                    }
                }
            }
        }
        .onAppear {
            viewModel.context = context
        }
    }
    
    private var navBar: some View {
        HStack {
            Button(action : {
                router.pop()
            }) {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.black)
            }
            
            Spacer()
            
            Text("전자영수증")
                .font(.pretendardMedium(16))
            
            Spacer()
            
            Button(action : {
                showActionSheet = true
            }) {
                Image(systemName: "plus")
                    .foregroundStyle(.black)
            }
        }
        .padding()
        .background(.white)
    }
    
    private var topContentView: some View {
        let total = receipts.reduce(0) { $0 + $1.totalAmount }
        
        return HStack(spacing: 3) {
            Text("총")
                .foregroundStyle(.black)
                .font(.pretendardRegular(18))
            Text("\(receipts.count)건")
                .foregroundStyle(.brown01)
                .font(.pretendardSemiBold(18))
            
            Spacer()
            
            Text("사용합계")
                .foregroundStyle(.black)
                .font(.pretendardRegular(18))
            Text("\(total.formatted(.number.grouping(.automatic)))원")
                .foregroundStyle(.brown01)
                .font(.pretendardSemiBold(18))
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 19)
    }
    
    private var bottomContentView: some View {
        List {
            ForEach(receipts, id: \.id) { receipt in
                ReceiptList(model: receipt)
                    .listRowInsets(EdgeInsets.init(top: 14, leading: 19, bottom: 0, trailing: 19))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.white01)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            context.delete(receipt)
                            try? context.save()
                        } label: {
                            Label("삭제", systemImage: "trash")
                        }
                    }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ReceiptView()
        .environment(NavigationRouter())
}
