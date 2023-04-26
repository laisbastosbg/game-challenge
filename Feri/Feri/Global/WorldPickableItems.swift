//
//  WorldPickableItems.swift
//  Feri
//
//  Created by Lais Godinho on 25/04/23.
//

import Foundation
import SpriteKit

class WorldPickableItems {
    static var shared = WorldPickableItems()
    var items: [PickableItem] = []

    private init() {
        items = generatePickableItems()
    }

    func listPickableItems() {
        print("------------")
        for e in WorldPickableItems.shared.items {
            print(e.name)
        }
        print("------------")
    }
    func getPickableItem(name: String) -> PickableItem {
        print(">>>>> \(name)")
        let items = WorldPickableItems.shared.items.filter { $0.name == name}
        guard let item = items.first else {
            fatalError()
        }

        return item
    }

    func generatePickableItems() -> [PickableItem] {
        let balconyKey = PickableItem(name: "balconyKey", remainingUses: 1, textureName: "TileSet-chave")

        let bathroomKey = PickableItem(name: "bathroomKey", remainingUses: 1, textureName: "TileSet-chaveBanheiro")

        let crowbar = PickableItem(name: "crowbar", remainingUses: 2, textureName: "crowbar")

        let ropes = PickableItem(name: "ropes", remainingUses: 1, textureName: "TileSet-corda")

        let lantern = PickableItem(name: "lantern", remainingUses: 1, textureName: "TileSet-lanterna")

        let plunger = PickableItem(name: "plunger", remainingUses: 1, textureName: "TileSet-chaveBanheiro")

        let storageKey = PickableItem(name: "storageKey", remainingUses: 1, textureName: "TileSet-chave")

        let stool = PickableItem(name: "stool", remainingUses: 1, textureName: "TileSet-banquinho")

        return [
            balconyKey,
            bathroomKey,
            crowbar,
            ropes,
            lantern,
            plunger,
            storageKey,
            stool
        ]
    }
    
}

