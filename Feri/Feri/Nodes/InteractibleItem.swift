//
//  InteractibleItem.swift
//  Feri
//
//  Created by Lais Godinho on 04/04/23.
//

import Foundation
import SpriteKit

class InteractibleItem: SKSpriteNode{
    
    var identifier: String
    var compatiblePickableItems: [PickableItem]
    private(set) var tileMapPosition: [Point] = []


    init(identifier: String, compatiblePickItems: [PickableItem] = [], texture: SKTexture, position: Point) {
        self.identifier = identifier
        self.compatiblePickableItems = compatiblePickItems
        self.tileMapPosition.append(position)
        super.init(texture: texture, color: .clear, size: texture.size())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func interact(with itemFromInventory: PickableItem) throws {
        if compatiblePickableItems.contains(where: { element in
            element.name == itemFromInventory.name
        }) {
            try itemFromInventory.use()
        } else {
            throw InteractibleItemError.incompatibleItem
        }
    }

    func interact() {
        for item in Inventory.shared.items {
            do {
                try interact(with: item)
            } catch {
                //TODO: tratar erro
                print("You have no items to use with this object")
            }
        }
    }
    
}

enum InteractibleItemError: Error {
    case incompatibleItem
}

extension InteractibleItemError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .incompatibleItem:
            return NSLocalizedString(
                "This item cannot be used on this object",
                comment: "Incompatible Item")
        }
    }
}
