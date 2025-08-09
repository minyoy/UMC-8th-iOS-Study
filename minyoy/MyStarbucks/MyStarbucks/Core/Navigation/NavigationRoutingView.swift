//
//  NavigationRoutingView.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/29/25.
//

import SwiftUI

struct RootView: View {
    /// DIContainer 의존성 주입
    @StateObject private var container: DIContainer = .init()
    
    @State private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack(path: $container.navigationRouter.path) {
            Group {
                if let user = KeychainService.shared.load() {
                    BaseTabView()
                        .environmentObject(container)
                        .environment(viewModel)
                } else {
                    LoginView()
                        .environmentObject(container)
                }
            }
                .navigationDestination(for: NavigationDestination.self) { route in
                    Group {
                        switch route {
                        case .login:
                            LoginView()
                        case .signup:
                            SignupView()
                        case .baseTab:
                            BaseTabView()
                                .environment(viewModel)
                        case .coffeeDetail:
                            CoffeeDetailView()
                                .environment(viewModel)
                        case .recepit:
                            ReceiptView()
                        case .findStore:
                            FindStoreView()
                        }
                    }
                    .environmentObject(container)
                }
        }
    }
}

#Preview {
    RootView()
}
