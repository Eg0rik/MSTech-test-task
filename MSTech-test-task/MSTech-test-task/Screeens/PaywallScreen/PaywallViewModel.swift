//
//  File.swift
//  MSTech-test-task
//
//  Created by Egor on 2.01.26.
//

import Combine
import SwiftUI

final class PaywallViewModel: ObservableObject {
    @Published private(set) var subscriptions: [Subscription] = Subscription.testData
    @Published var selectedSubscription: Subscription? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    private let myStorage = MyStorage()
    
    init() {
        checkIfUserSelectedSubscription()
        setupSubscribers()
    }
}

private extension PaywallViewModel {
    func setupSubscribers() {
        $selectedSubscription
            .sink { [weak self] subscription in
                guard let self = self, let subscription else { return }
                
                self.myStorage.selectedSubscriptionId = subscription.id
            }
            .store(in: &cancellables)
    }
    
    func checkIfUserSelectedSubscription() {
        if let selectedSubscriptionId = myStorage.selectedSubscriptionId {
            selectedSubscription = subscriptions.first(where: { $0.id == selectedSubscriptionId })
        }
    }
}

#Preview {
    RootScreen()
}
