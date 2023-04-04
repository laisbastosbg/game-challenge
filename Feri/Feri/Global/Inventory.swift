//
//  Inventory.swift
//  Feri
//
//  Created by Lais Godinho on 04/04/23.
//

import Foundation

class Inventory {
    static let shared = Inventory()
    var items: [PickableItem]

    private init(items: [PickableItem] = []) {
        self.items = items
    }
}
