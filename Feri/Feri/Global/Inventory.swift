//
//  Inventory.swift
//  Feri
//
//  Created by Lais Godinho on 04/04/23.
//

import Foundation
class Inventory: ObservableObject {
    
    static let shared = Inventory()
    @Published private(set) var items: [PickableItem] = []

    private init(items: [PickableItem] = []) {
        self.items = items
    }

    func addItem(newItem: PickableItem) {
        if !Inventory.shared.items.contains(newItem) {
            Inventory.shared.items.append(newItem)
        }
    }

    func removeItem(item: PickableItem) {
        Inventory.shared.items.removeAll(where: { $0 == item })
    }
}
