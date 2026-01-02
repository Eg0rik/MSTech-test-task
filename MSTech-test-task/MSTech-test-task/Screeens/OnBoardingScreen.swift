//
//  OnBoardingScreen.swift
//  MSTech-test-task
//
//  Created by Egor on 2.01.26.
//

import SwiftUI

struct OnBoardingScreen: View {
    @State private var currentStep: Step = .step1
    @EnvironmentObject private var navigationViewModel: NavigationViewModel
    
    private let myStorage = MyStorage()
    private let imageSize: CGFloat = 34
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: currentStep.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: imageSize, height: imageSize)
            
            Text(currentStep.title)
                .font(.system(size: 24, weight: .medium))
            
            Spacer()
            
            MainButton(text: "Continue", disabled: false) {
                nextStep()
            }
                
        }
        .foregroundStyle(.white)
        .padding(.horizontal)
        .background(.appPurple5)
    }
}

private extension OnBoardingScreen {
    func nextStep() {
        switch currentStep {
            case .step1: currentStep = .step2
            case .step2:
                myStorage.isOnBoardingCompleted = true
                navigationViewModel.currentScreen = .home
        }
    }
}

private extension OnBoardingScreen {
    enum Step {
        case step1
        case step2
        
        var title: String {
            switch self {
                case .step1: "Learn the basics of programming"
                case .step2: "Complete quizzes and get statistics on them"
            }
        }
        
        var imageName: String {
            switch self {
                case .step1: "tray.full.fill"
                case .step2: "arrow.up.page.on.clipboard"
            }
        }
    }
}

#Preview {
    RootScreen()
}
