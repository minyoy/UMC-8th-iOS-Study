//
//  MovieView.swift
//  week2_practice
//
//  Created by 주민영 on 3/24/25.
//

import SwiftUI

struct MovieView: View {
    @AppStorage("movieName") var movieName: String = ""
    private var viewModel: MovieViewModel = .init()
    
    var body: some View {
        VStack(spacing: 56) {
            MovieCard(movieInfo: viewModel.movieModel[viewModel.currentIndex])
            
            changeMovieView
            
            bestBtn
            
            appStorageDisplay
        }
        .padding()
    }
    
    private var changeMovieView: some View {
        HStack(spacing: 61) {
            Button(action: {
                viewModel.previousMovie()
                print("왼쪽 화살표를 클릭했습니다.")
            }, label: {
                Image(systemName: "chevron.left")
                    .resizable()
                    .frame(width: 18, height: 30)
                    .foregroundStyle(.black)
            })
            
            Text("영화 바꾸기")
                .font(.system(size: 20, weight: .regular))
            
            Button(action: {
                viewModel.nextMovie()
                print("오른쪽 화살표를 클릭했습니다.")
            }, label: {
                Image(systemName: "chevron.right")
                    .resizable()
                    .frame(width: 18, height: 30)
                    .foregroundStyle(.black)
            })
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 17)
    }
    
    private var bestBtn: some View {
        Button(action: {
            movieName = viewModel.movieModel[viewModel.currentIndex].movieName
        }, label: {
            Text("대표 영화로 설정")
                .font(.system(size: 20, weight: .regular))
                .foregroundStyle(.black)
                .padding(EdgeInsets(top: 21, leading: 53, bottom: 20, trailing: 52))
                .overlay(content: {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.clear)
                        .stroke(.black, lineWidth: 1)
                })
        })
    }
    
    private var appStorageDisplay: some View {
        VStack(spacing: 17) {
            Text("@AppStorage에 저장된 영화")
                .foregroundStyle(.black)
                .font(.system(size: 30, weight: .regular))
            Text("현재 저장된 영화 : \(movieName)")
                .foregroundStyle(.red)
                .font(.system(size: 20, weight: .regular))
        }
    }
}

#Preview {
    MovieView()
}
