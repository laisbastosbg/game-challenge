//
//  PickableItem.swift
//  Feri
//
//  Created by Lais Godinho on 04/04/23.
//

import Foundation
import SpriteKit

class PickableItem: Equatable {
    static func == (lhs: PickableItem, rhs: PickableItem) -> Bool {
        return (lhs.spriteNode == rhs.spriteNode) && (lhs.name == rhs.name)
    }
    
    var name: String
    
    var remainingUses: Int {
        didSet {
            if self.remainingUses <= 0 {
                Inventory.shared.items.removeAll(where: { $0 == self })
            }
        }
    }

    var spriteNode: SKSpriteNode

    init(name: String, remainingUses: Int, spriteNode: SKSpriteNode) {
        self.name = name
        self.remainingUses = remainingUses
        self.spriteNode = spriteNode
    }

    func use() throws {
        if self.remainingUses > 0 {
            self.remainingUses -= 1
        } else {
            throw PickableItemError.insufficientUses
        }
    }
}

enum PickableItemError: Error {
    case insufficientUses
}

extension PickableItemError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .insufficientUses:
            return NSLocalizedString(
                "This item has no more uses",
                comment: "Insufficient uses")
        }
    }
}
