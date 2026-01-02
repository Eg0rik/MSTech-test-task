//
//  NavigationViewModel.swift
//  MSTech-test-task
//
//  Created by Egor on 2.01.26.
//

import Combine
import SwiftUI

final class NavigationViewModel: ObservableObject {
    @Published var currentScreen = Screen.onBoarding
    private let myStorage = MyStorage()
    
    init() {
        if myStorage.isOnBoardingCompleted {
            currentScreen = .home
        } else {
            currentScreen = .onBoarding
        }
    }
}
