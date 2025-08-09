//
//  RootView.swift
//  MyStarbucks
//
//  Created by 주민영 on 3/29/25.
//

import SwiftUI

struct RootView: View {
    @State private var router = NavigationRouter()
    @State private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            Group {
                if let user = KeychainService.shared.load() {
                    BaseTabView()
                        .environment(router)
                        .environment(viewModel)
                } else {
                    LoginView()
                        .environment(router)
                }
            }
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .login:
                        LoginView()
                            .environment(router)
                    case .signup:
                        SignupView()
                            .environment(router)
                    case .baseTab:
                        BaseTabView()
                            .environment(router)
                            .environment(viewModel)
                    case .coffeeDetail:
                        CoffeeDetailView()
                            .environment(router)
                            .environment(viewModel)
                    case .recepit:
                        ReceiptView()
                            .environment(router)
                    case .findStore:
                        FindStoreView()
                            .environment(router)
                    }
                }
        }
    }
}

#Preview {
    RootView()
}
