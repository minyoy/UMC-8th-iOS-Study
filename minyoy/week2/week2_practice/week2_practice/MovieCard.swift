//
//  MovieCard.swift
//  week2_practice
//
//  Created by 주민영 on 3/24/25.
//

import SwiftUI

struct MovieCard: View {
    let movieInfo: MovieModel
        
    init(movieInfo: MovieModel) {
        self.movieInfo = movieInfo
    }
    
    var body: some View {
        VStack(spacing: 5) {
            movieInfo.movieImage
                .frame(width: 120, height: 172)
            
            Text(movieInfo.movieName)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.black)
            
            HStack {
                movieLike
                
                Spacer()
                
                Text("예매율 \(String(format: "%.1f", movieInfo.movieReserCount))%")
                    .font(.system(size: 9, weight: .regular))
            }
        }
        .frame(width: 120, height: 216)
    }
    
    /// 하단 영화 좋아요
    private var movieLike: some View {
        HStack(spacing: 6) {
            Image(systemName: "heart.fill")
                .resizable()
                .frame(width: 15, height: 14)
                .foregroundStyle(.red)
            
            Text("\(movieInfo.movieLike)")
                .font(.system(size: 9, weight: .regular))
                .foregroundStyle(Color.black)
        }
    }
}

#Preview {
    MovieCard(movieInfo:  .init(movieImage: .init(.mickey), movieName: "미키", movieLike: 972, movieReserCount: 30.8))
}
