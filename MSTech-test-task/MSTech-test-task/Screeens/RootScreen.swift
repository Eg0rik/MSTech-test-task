//
//  RootScreen.swift
//  MSTech-test-task
//
//  Created by Egor on 2.01.26.
//

import SwiftUI

struct RootScreen: View {
    @StateObject private var navigationViewModel = NavigationViewModel()
    
    var body: some View {
        NavigationView {
            build(navigationViewModel.currentScreen)
        }
    }
}

private extension RootScreen {
    @ViewBuilder
    func getScreen(_ route: Screen) -> some View {
        switch route {
            case .home: HomeScreen()
            case .onBoarding: OnBoardingScreen()
            case .paywall: PaywallScreen()
            default: Text("No such screen")
        }
    }
    
    @ViewBuilder
    func build(_ route: Screen) -> some View {
        getScreen(route)
            .environmentObject(navigationViewModel)
    }
}

#Preview {
    RootScreen()
}
