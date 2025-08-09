//
//  StoreListItem.swift
//  MyStarbucks
//
//  Created by 주민영 on 4/11/25.
//

import SwiftUI
import Kingfisher

struct StoreListItem: View {
    @State var viewModel: StoreListItemViewModel = .init()
    @State var photo_reference: String? = nil
    
    let model: StoreFeature
    
    init(model: StoreFeature) {
        self.model = model
    }
    
    var body: some View {
        HStack(spacing: 16) {
            let imageURL = photo_reference.flatMap {
                URL(string: "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=\($0)&key=\(Config.apiKey)")
            }
            
            KFImage(imageURL)
                .placeholder({
                    ProgressView()
                        .controlSize(.mini)
                })
                .onFailure { error in
                    print("이미지 로드 실패: \(error)")
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 83, height: 83)
                .clipShape(RoundedRectangle(cornerRadius: 6))
            
            contentView
        }
        .onAppear{
            Task {
                self.photo_reference = await viewModel.getPhotoReference(Store_nm: model.properties.Sotre_nm)
            }
        }
    }
    
    private var contentView: some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading, spacing: 3) {
                Text(model.properties.Sotre_nm)
                    .foregroundStyle(.black03)
                    .font(.pretendardSemiBold(13))
                
                Text(model.properties.Address)
                    .foregroundStyle(.gray02)
                    .font(.pretendardMedium(10))
            }
            
            HStack(alignment: .center, spacing: 0) {
                HStack(spacing: 4) {
                    if model.properties.storeCategory == .reserve || model.properties.storeCategory == .dtr {
                        Image("R")
                    }
                    if model.properties.storeCategory == .dt || model.properties.storeCategory == .dtr {
                        Image("D")
                    }
                }
                
                Spacer()
                
                Text("\(String(format: "%.1f km", model.properties.KM ?? 0.0))")
                    .font(.pretendardMedium(12))
            }
        }
    }
}
