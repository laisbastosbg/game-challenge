//
//  WorldItems.swift
//  Feri
//
//  Created by Lais Godinho on 25/04/23.
//

import Foundation
import SpriteKit

class WorldItems {
    static var shared = WorldItems()
    var items: [PickableItem] = []

    private init() {

        let balconyKey = PickableItem(name: "balconyKey", remainingUses: 1, texture: SKTexture(imageNamed: "TileSet-chave"))

        let bathroomKey = PickableItem(name: "bathroomKey", remainingUses: 1, texture: SKTexture(imageNamed: "TileSet-chaveBanheiro"))

        let crowbar = PickableItem(name: "crowbar", remainingUses: 2, texture: SKTexture(imageNamed: "objetos"))

        let ropes = PickableItem(name: "ropes", remainingUses: 1, texture: SKTexture(imageNamed: "TileSet-corda"))

        let lantern = PickableItem(name: "lantern", remainingUses: 1, texture: SKTexture(imageNamed: "TileSet-lanterna"))

        let plunger = PickableItem(name: "plunger", remainingUses: 1, texture: SKTexture(imageNamed: "TileSet-chaveBanheiro"))

        let storageKey = PickableItem(name: "storageKey", remainingUses: 1, texture: SKTexture(imageNamed: "TileSet-chave"))

        items = [
            balconyKey,
            bathroomKey,
            crowbar,
            ropes,
            lantern,
            plunger,
            storageKey
        ]
    }

    func getItem(name: String) -> PickableItem {
        print(">>>>> \(name)")
        let items = WorldItems.shared.items.filter { $0.name == name}
        guard let item = items.first else {
            fatalError()
        }

        return item
    }
    
}
//
//extension WorldItems {
//    private func createWorldItems() -> [PickableItem] {
//        var items: [PickableItem] = []
//
//        let balconyKey = PickableItem(name: "balconyKey", remainingUses: 1, texture: SKTexture(imageNamed: "TileSet-chave"))
//
//        let bathroomKey = PickableItem(name: "bathroomKey", remainingUses: 1, texture: SKTexture(imageNamed: "TileSet-chaveBanheiro"))
//
//        let crowbar = PickableItem(name: "crowbar", remainingUses: 2, texture: SKTexture(imageNamed: "objetos"))
//
//        let ropes = PickableItem(name: "ropes", remainingUses: 1, texture: SKTexture(imageNamed: "TileSet-corda"))
//
//        let lantern = PickableItem(name: "lantern", remainingUses: 1, texture: SKTexture(imageNamed: "TileSet-lanterna"))
//
//        let plunger = PickableItem(name: "bathroomKey", remainingUses: 1, texture: SKTexture(imageNamed: "TileSet-chaveBanheiro"))
//
//        let storageKey = PickableItem(name: "storageKey", remainingUses: 1, texture: SKTexture(imageNamed: "TileSet-chave"))
//
//        items = [
//            balconyKey,
//            bathroomKey,
//            crowbar,
//            ropes,
//            lantern,
//            plunger,
//            storageKey
//        ]
//
//        return items
//    }
//}
