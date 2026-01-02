//
//  subscription.swift
//  MSTech-test-task
//
//  Created by Egor on 2.01.26.
//

import Foundation

struct Subscription: Identifiable, Codable {
    let name: String
    let price: Double
    let discount: Double?
    let features: [String]
    let isMostPopular: Bool
    
    var id: String {
        name
    }
}

#if DEBUG
extension  Subscription {
    static let testData = [
        Subscription(
            name: "Ежемесячная",
            price: 299,
            discount: nil,
            features: ["Все функции", "Без рекламы", "Ежедневные обновления", "Поддержка"],
            isMostPopular: false
        ),
        Subscription(
            name: "Годовая",
            price: 1990,
            discount: 45,
            features: ["Все функции", "Без рекламы", "Ежедневные обновления", "Приоритетная поддержка", "Эксклюзивный контент"],
            isMostPopular: true
        ),
    ]
}
#endif
