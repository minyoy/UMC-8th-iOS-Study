//
//  HomeView.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/25/25.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("nickname") private var nickname: String = "(설정 닉네임)"
    
    @Environment(NavigationRouter.self) private var router
    @Environment(HomeViewModel.self) var viewModel
    
    @State private var progress = 0.45
    
    var body: some View {
        ScrollView {
            bannerView
            
            contentView
        }
        .ignoresSafeArea(.all)
    }
    
    // 전체 콘텐츠뷰
    private var contentView: some View {
        VStack(alignment: .leading, spacing: 20) {
            Image("adBanner")
                .fixedSize()
                .padding(.horizontal, 10)
            
            recommendView
                .padding(.leading, 10)
            
            Image("eventBanner")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, minHeight: 180)
                .padding(.horizontal, 10)
            
            Image("serviceSuscibe")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, minHeight: 200)
                .padding(.horizontal, 10)
            
            whatNewView
                .padding(.leading, 10)
            
            bannersView
                .padding(.horizontal, 10)
            
            dessertView
                .padding(.leading, 10)
            
            bannersView2
                .padding(.horizontal, 10)
        }
        .padding(.top, 30)
    }
    
    // 콜드브루 배너 & 대표 음료 배너 & 스타벅스 제조 배너
    private var bannersView2: some View {
        VStack(spacing: 20) {
            Image("coldbrewBanner")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, minHeight: 182)
            
            Image("signatureDrinkBanner")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, minHeight: 360)
            
            Image("manufacturingBanner")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, minHeight: 180)
        }
    }
    
    // 디저트
    private var dessertView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("하루가 달콤해지는 디저트")
                .foregroundStyle(.black03)
                .font(.pretendardBold(24))
                .padding(.horizontal, 10)
            
            ScrollView(.horizontal, content: {
                // 가려지는 부분도 있는 가로 스크롤뷰여서 LazyHStack 채택함
                LazyHStack(spacing: 16, content: {
                    ForEach(viewModel.dummyDessert, id: \.id) { dessert in
                        CircleImageCard(model: dessert)
                    }
                })
            })
            .scrollIndicators(.hidden)
            .padding(.leading, 10)
        }
    }
    
    // 머그세트 배너 & 온라인 스토어 배너 & 배달 서비스 배너
    private var bannersView: some View {
        VStack(spacing: 14) {
            Image("mugcupBanner")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, minHeight: 218)
            
            Image("onlineStoreBanner")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, minHeight: 273)
            
            Image("deliveryBanner")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, minHeight: 218)
        }
    }
    
    // What's New
    private var whatNewView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What’s New")
                .foregroundStyle(.black03)
                .font(.pretendardBold(24))
                .padding(.horizontal, 10)
            
            ScrollView(.horizontal, content: {
                // 가려지는 부분도 있는 가로 스크롤뷰여서 LazyHStack 채택함
                LazyHStack(spacing: 16, content: {
                    ForEach(viewModel.dummyNews, id: \.id) { new in
                        NewsCard(news: new)
                    }
                })
            })
            .scrollIndicators(.hidden)
            .padding(.leading, 10)
        }
    }
    
    // 추천 메뉴
    private var recommendView: some View {
        VStack(alignment: .leading, spacing: 25) {
            HStack(spacing: 0) {
                Text(nickname)
                    .foregroundStyle(.brown01)
                    .font(.pretendardBold(24))
                Text("님을 위한 추천 메뉴")
                    .foregroundStyle(.black)
                    .font(.pretendardBold(24))
            }
            .padding(.horizontal, 10)
            
            ScrollView(.horizontal, content: {
                // 가려지는 부분도 있는 가로 스크롤뷰여서 LazyHStack 채택함
                LazyHStack(spacing: 16, content: {
                    ForEach(viewModel.dummyCoffees, id: \.id) { coffee in
                        CircleImageCard(model: coffee)
                            .onTapGesture {
                                viewModel.selectedCoffeeModel = coffee
                                router.push(.coffeeDetail)
                            }
                    }
                })
            })
            .scrollIndicators(.hidden)
            .padding(.leading, 10)
        }
    }
    
    // 맨 위 배너뷰
    private var bannerView: some View {
        ZStack(alignment: .bottomLeading) {
            Image("banner")
            
            VStack(alignment: .leading) {
                Text("골든 미모사 그린 티와 함께\n행복한 새해의 축배를 들어요!")
                    .font(.pretendardBold(24))
                    .foregroundStyle(.black03)
                
                Spacer()
                    .frame(maxHeight: 29)
                
                bottomBannerView
            }
            .padding(.horizontal, 28)
            .padding(.bottom, -25)
        }
    }
    
    // 맨 위 배너뷰 아래 컴포넌트들
    private var bottomBannerView: some View {
        HStack(alignment: .bottom) {
            rewardBarView
            
            Spacer()
            
            VStack(spacing: 3) {
                showDetailsBtn
                rewardNumber
            }
        }
        .padding(.bottom, 5)
    }
    
    // 왼쪽 리워드 프로그래스바
    private var rewardBarView: some View {
        ProgressView(value: progress) {
            Text("11★ until next Reward")
                .font(.pretendardSemiBold(16))
                .foregroundStyle(.brown02)
        }
        .tint(.brown01)
        .presentationCornerRadius(4)
        .frame(width: 255, height: 35)
    }
    
    // 1/12★ 라벨
    private var rewardNumber: some View {
        HStack(spacing: 5) {
            Text("1")
                .foregroundStyle(.black03)
                .font(.pretendardSemiBold(38))
            Text("/")
                .foregroundStyle(.gray)
                .font(.PretendardLight(24))
            HStack(alignment: .bottom, spacing: 0) {
                Text("12")
                    .foregroundStyle(.brown02)
                    .font(.pretendardSemiBold(24))
                Text("★")
                    .foregroundStyle(.brown02)
                    .font(.pretendardSemiBold(14))
                    .padding(.bottom, 2)
            }
        }
    }
    
    // 내용 보기 버튼
    private var showDetailsBtn: some View {
        Button(action: {
            print("내용 보기")
        }, label: {
            HStack(alignment: .center, spacing: 4) {
                Text("내용 보기")
                    .kerning(-0.5)
                    .foregroundStyle(.gray06)
                    .font(.PretendardRegular13)
                
                Image("leftArrow")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10, height: 10)
            }
        })
    }
}

#Preview {
    HomeView()
        .environment(NavigationRouter())
        .environment(HomeViewModel())
}
