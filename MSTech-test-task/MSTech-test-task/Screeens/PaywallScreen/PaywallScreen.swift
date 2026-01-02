//
//  PaywallScreen.swift
//  MSTech-test-task
//
//  Created by Egor on 2.01.26.
//

import SwiftUI

struct PaywallScreen: View {
    @EnvironmentObject private var paywallViewModel: PaywallViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            backgroundGradient
            
            ScrollView {
                VStack(spacing: 0) {
                    headerSection
                    
                    featuresSection
                    
                    subscriptionsList
                    
                    footerSection
                }
            }
        }
    }
}

private extension PaywallScreen {
    var backgroundGradient: some View {
        LinearGradient(
            colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
    
    var headerSection: some View {
        VStack(spacing: 16) {
            Image(systemName: "crown.fill")
                .font(.system(size: 60))
                .foregroundStyle(crownGradient)
            
            VStack(spacing: 8) {
                Text("Премиум доступ")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text("Откройте все возможности приложения")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.top, 40)
        .padding(.bottom, 30)
    }
    
    var crownGradient: LinearGradient {
        LinearGradient(
            colors: [.yellow, .orange],
            startPoint: .top,
            endPoint: .bottom
        )
    }
    
    var featuresSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Что включено:")
                .font(.title2)
                .fontWeight(.semibold)
            
            ForEach(featuresList, id: \.self) { feature in
                HStack(spacing: 12) {
                    Text(feature)
                        .font(.body)
                    Spacer()
                }
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .padding(.horizontal)
        .padding(.bottom, 30)
    }
    
    var featuresList: [String] {
        [
            "✅ Все функции разблокированы",
            "✅ Без рекламы",
            "✅ Ежедневные обновления",
            "✅ Приоритетная поддержка",
            "✅ Эксклюзивный контент"
        ]
    }
    
    var subscriptionsList: some View {
        VStack(spacing: 20) {
            ForEach(paywallViewModel.subscriptions) { subscription in
                SubscriptionCard(subscription: subscription) {
                    paywallViewModel.selectedSubscription = subscription
                    dismiss()
                }
            }
        }
        .padding(.horizontal)
    }
    
    var footerSection: some View {
        VStack(spacing: 12) {
            termsText
            
            restorePurchasesButton
        }
        .padding(.top, 30)
        .padding(.horizontal)
        .padding(.bottom, 40)
    }
    
    var termsText: some View {
        Text("Нажав на кнопку, вы соглашаетесь с нашими Условиями использования и Политикой конфиденциальности. Подписка автоматически продлевается, если не отменена за 24 часа до окончания периода.")
            .font(.caption)
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
    }
    
    var restorePurchasesButton: some View {
        Button("Восстановить покупки") {
            // Восстановление покупок
        }
        .font(.caption)
        .foregroundColor(.blue)
    }
}

#Preview {
    RootScreen()
}
