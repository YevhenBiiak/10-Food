//
//  LocalRepository.swift
//  10 Food
//
//  Created by Yevhen Biiak on 25.01.2023.
//

import Foundation

protocol LocalRepository: AnyObject {
    associatedtype Model: Identifiable
    var items: [Model] { set get }
    func add(_ item: Model)
    func remove(_ item: Model)
    func fetch()
    func save()
}

extension LocalRepository where Model: Codable {
    
    func add(_ item: Model) {
        items.append(item)
    }
    
    func remove(_ item: Model) {
        items.removeAll { $0.id == item.id }
    }
    
    private var defaults: UserDefaults { UserDefaults.standard }
    private var key: String { String(describing: Model.self) }
    
    func fetch() {
        let data = defaults.array(forKey: key) as? [Data] ?? []
        items = data.compactMap { try? JSONDecoder().decode(Model.self, from: $0) }
    }
    
    func save() {
        let data = items.compactMap { try? JSONEncoder().encode($0) }
        defaults.set(data, forKey: key)
    }
}

class FavoritesRepository: LocalRepository, FavoritesManager {
    
    var items: [FoodItem] = []
    
    func isFavorite(_ foodItem: FoodItem) -> Bool {
        items.contains(where: { $0.id == foodItem.id })
    }
    
    deinit { save() }
}

class OrdersRepository: LocalRepository, OrdersManager {
    var items: [OrderItem] = []
    deinit { save() }
}
