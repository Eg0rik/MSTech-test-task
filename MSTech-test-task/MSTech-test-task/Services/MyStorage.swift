//
//  MyStorage.swift
//  MSTech-test-task
//
//  Created by Egor on 2.01.26.
//

import Foundation

class MyStorage {
    private let defaults = UserDefaults.standard
    init() { }
    
    var isOnBoardingCompleted: Bool {
        get { get(Bool.self, forKey: "isOnBoardingCompleted") ?? false }
        set { save(newValue, forKey: "isOnBoardingCompleted") }
    }
    
    var selectedSubscriptionId: String? {
        get { get(String.self, forKey: "selectedSubscriptionId") }
        set { save(newValue, forKey: "selectedSubscriptionId") }
    }
    
    func save<T: Codable>(_ value: T, forKey key: String) {
        do {
            let data = try JSONEncoder().encode(value)
            defaults.set(data, forKey: key)
        } catch {
            print(error)
        }
    }

    func get<T: Codable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = defaults.data(forKey: key) else { return nil }
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            return nil
        }
    }

    func delete(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
}
