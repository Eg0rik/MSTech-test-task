//
//  SubscriptionCard.swift
//  MSTech-test-task
//
//  Created by Egor on 2.01.26.
//
import SwiftUI

struct SubscriptionCard: View {
    let subscription: Subscription
    let action: () -> ()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            headerView
            
            // Цена
            priceView
            
            // Особенности подписки
            subscriptoinFeatures
            
            chooseButton
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(24)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(subscription.isMostPopular ?
                        Color.blue :
                       Color.clear,
                       lineWidth: 2)
        )
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}

private extension SubscriptionCard {
    var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(subscription.name)
                    .font(.title3)
                    .fontWeight(.bold)
                
                if let discount = subscription.discount {
                    HStack(spacing: 6) {
                        Text("-\(Int(discount))%")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.green)
                            .cornerRadius(6)
                        
                        Text("Экономия \(Int(discount))%")
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                }
            }
            
            Spacer()
            
            if subscription.isMostPopular {
                Text("Популярно")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(12)
            }
        }
    }
    
    var priceView: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text("\(Int(subscription.price)) ₽")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("/мес")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
    }
    
    var subscriptoinFeatures: some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(subscription.features, id: \.self) { feature in
                HStack(spacing: 12) {
                    Circle()
                        .fill(Color.green.opacity(0.2))
                        .frame(width: 24, height: 24)
                        .overlay(
                            Image(systemName: "checkmark")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.green)
                        )
                    
                    Text(feature)
                        .font(.subheadline)
                        .foregroundColor(.primary)
                    
                    Spacer()
                }
            }
        }
    }
    
    var chooseButton: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text(subscription.isMostPopular ? "Выбрать" : "Продолжить")
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding()
            .background(
                subscription.isMostPopular ?
                LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing) :
                    LinearGradient(colors: [Color.primary.opacity(0.1), Color.primary.opacity(0.1)], startPoint: .leading, endPoint: .trailing)
            )
            .foregroundColor(subscription.isMostPopular ? .white : .primary)
            .cornerRadius(16)
        }
    }
}

#Preview {
    RootScreen()
}
