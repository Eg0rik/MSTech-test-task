//
//  Screen.swift
//  MSTech-test-task
//
//  Created by Egor on 2.01.26.
//

import Foundation

enum Screen: Identifiable {
    case onBoarding
    case home
    case paywall
    
    var id: UUID {
        UUID()
    }
}
