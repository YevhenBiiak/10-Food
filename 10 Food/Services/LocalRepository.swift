//
//  LocalRepository.swift
//  10 Food
//
//  Created by Yevhen Biiak on 25.01.2023.
//

import Foundation

protocol LocalRepository: AnyObject {
    associatedtype Model
    var items: [Model] { set get }
    func add(_ item: Model)
    func remove(_ item: Model)
    func fetch()
    func save()
}

extension LocalRepository where Model: Codable & Identifiable {
    
    func add(_ item: Model) {
        items.append(item)
    }
    
    func remove(_ item: Model) {
        items.removeAll { $0.id == item.id }
    }
    
    private var defaults: UserDefaults { UserDefaults.standard }
    private var key: String { String(reflecting: Self.self) + String(reflecting: Self.Model.self) }
    
    func fetch() {
        let data = defaults.array(forKey: key) as? [Data] ?? []
        items = data.compactMap { try? JSONDecoder().decode(Model.self, from: $0) }
    }
    
    func save() {
        let data = items.compactMap { try? JSONEncoder().encode($0) }
        defaults.set(data, forKey: key)
    }
}

// MARK: - FavoritesRepository

class FavoritesRepository: LocalRepository, FavoritesManager {
    
    var items: [FoodItem] = []
    
    func isFavorite(_ foodItem: FoodItem) -> Bool {
        items.contains(where: { $0.id == foodItem.id })
    }
}

// MARK: - OrdersRepository

class OrdersRepository: LocalRepository, OrdersManager {
    
    var items: [FoodItem] = [] {
        didSet { notify() }
    }
    
    var cartAmount: Int {
        items.reduce(0) { $0 + $1.price }
    }
    
    var orderItems: [OrderItem] {
        var orderItems: [OrderItem] = []
        for item in items {
            if let index = orderItems.firstIndex(where: { $0.foodItem.id == item.id }) {
                let oldItem = orderItems[index]
                let newItem = OrderItem(foodItem: oldItem.foodItem, qty: oldItem.qty + 1)
                orderItems[index] = newItem
            } else {
                orderItems.append(OrderItem(foodItem: item, qty: 1))
            }
        }
        return orderItems
    }
    
    func remove(_ foodItem: FoodItem) {
        guard let index = items.firstIndex(where: { $0.id == foodItem.id }) else { return }
        items.remove(at: index)
    }
    
    func removeAll() {
        items = []
    }
    
    func count(of foodItem: FoodItem) -> Int {
        items.filter { $0.id == foodItem.id }.count
    }
    
    func observe(_ observer: Any, selector: Selector) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: .orderListDidChange, object: nil)
    }
    
    private func notify() {
        NotificationCenter.default.post(name: .orderListDidChange, object: nil)
    }
}

private extension NSNotification.Name {
    static let orderListDidChange = NSNotification.Name("orderListDidChange")
}
