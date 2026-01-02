//
//  HomeScreen.swift
//  MSTech-test-task
//
//  Created by Egor on 2.01.26.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject private var paywallViewModel = PaywallViewModel()
    @State private var showPaywallScreen = false
    
    var body: some View {
        ZStack {
            backgroundGradient
            
            ScrollView {
                VStack(spacing: 24) {
                    if let subscription = paywallViewModel.selectedSubscription {
                        SubscriptionDetailView(subscription: subscription)
                            .transition(.opacity.combined(with: .scale))
                    } else {
                        NoSubscriptionView()
                    }
                }
                .padding(.vertical, 24)
                .padding(.horizontal, 20)
            }
        }
        .navigationTitle("Моя подписка")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showPaywallScreen) {
            PaywallScreen()
                .environmentObject(paywallViewModel)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                subscriptionsButton
            }
        }
    }
}

private extension HomeScreen {
    var backgroundGradient: some View {
        LinearGradient(
            colors: [Color.blue.opacity(0.05), Color.purple.opacity(0.05)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
    
    var subscriptionsButton: some View {
        Button("Подписки") {
            showPaywallScreen = true
        }
    }
}

struct SubscriptionDetailView: View {
    let subscription: Subscription
    
    var body: some View {
        VStack(spacing: 0) {
            subscriptionHeader
            
            priceCard
            
            subscriptionFeatures
            
            subscriptionInfo
        }
    }
}

private extension SubscriptionDetailView {
    var subscriptionHeader: some View {
        VStack(spacing: 20) {
            ZStack {
                Circle()
                    .fill(subscriptionColor.opacity(0.15))
                    .frame(width: 100, height: 100)
                
                Image(systemName: subscriptionIconName)
                    .font(.system(size: 44))
                    .foregroundColor(subscriptionColor)
            }
            .padding(.top, 20)
            
            VStack(spacing: 8) {
                Text(subscription.name)
                    .font(.system(size: 34, weight: .bold))
                
                if subscription.isMostPopular {
                    mostPopularBadge
                }
            }
        }
        .padding(.bottom, 30)
    }
    
    var mostPopularBadge: some View {
        Text("САМЫЙ ВЫГОДНЫЙ")
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.green)
            .cornerRadius(8)
    }
    
    var priceCard: some View {
        VStack(spacing: 8) {
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text("\(Int(subscription.price)) ₽")
                    .font(.system(size: 44, weight: .heavy))
                
                Text(subscriptionPeriod)
                    .font(.title2)
                    .foregroundColor(.secondary)
            }
            
            if subscription.name == "Годовая" {
                Text("\(monthlyPrice) в месяц")
                    .font(.headline)
                    .foregroundColor(.secondary)
            }
            
            if let discount = subscription.discount {
                discountBadge(discount: discount)
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 20, x: 0, y: 10)
        )
        .padding(.horizontal)
        .padding(.bottom, 30)
    }
    
    func discountBadge(discount: Double) -> some View {
        Text("Экономия \(Int(discount))%")
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.green)
            .cornerRadius(12)
            .padding(.top, 4)
    }
    
    var subscriptionFeatures: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Что включено")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            VStack(spacing: 16) {
                ForEach(subscription.features, id: \.self) { feature in
                    HStack(spacing: 16) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title3)
                            .foregroundColor(.green)
                            .frame(width: 24)
                        
                        Text(feature)
                            .font(.body)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(12)
                }
            }
            .padding(.horizontal)
        }
        .padding(.bottom, 40)
    }
    
    var subscriptionInfo: some View {
        VStack(spacing: 16) {
            InfoRow(
                icon: "calendar.badge.clock",
                title: "Тип подписки",
                value: subscription.name
            )
            
            InfoRow(
                icon: "creditcard",
                title: "Цена",
                value: "\(Int(subscription.price)) ₽"
            )
            
            InfoRow(
                icon: "arrow.clockwise",
                title: "Статус",
                value: subscription.isMostPopular ? "Популярная" : "Стандартная"
            )
            
            if let discount = subscription.discount {
                InfoRow(
                    icon: "percent",
                    title: "Скидка",
                    value: "\(Int(discount))%"
                )
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
        )
        .padding(.horizontal)
    }
}

private extension SubscriptionDetailView {
    var monthlyPrice: String {
        let monthly = subscription.price / 12
        return String(format: "%.0f ₽", monthly)
    }
    
    var subscriptionIconName: String {
        switch subscription.name {
        case "Ежемесячная":
            return "calendar"
        case "Годовая":
            return "crown.fill"
        default:
            return "star.fill"
        }
    }
    
    var subscriptionColor: Color {
        switch subscription.name {
        case "Ежемесячная":
            return .blue
        case "Годовая":
            return .yellow
        default:
            return .purple
        }
    }
    
    var subscriptionPeriod: String {
        switch subscription.name {
        case "Ежемесячная":
            return "/месяц"
        case "Годовая":
            return "/год"
        default:
            return ""
        }
    }
}

struct NoSubscriptionView: View {
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
                .frame(height: 60)
            
            Image(systemName: "crown")
                .font(.system(size: 70))
                .foregroundColor(.gray.opacity(0.3))
            
            VStack(spacing: 12) {
                Text("Нет активной подписки")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Выберите подписку нажав кнопку 'подписки', чтобы получить доступ ко всем функциям")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            
            Spacer()
        }
    }
}

struct InfoRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.blue)
                .frame(width: 24)
            
            Text(title)
                .font(.body)
            
            Spacer()
            
            Text(value)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    RootScreen()
}
