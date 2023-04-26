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
    var storedPickableItem: PickableItem?
    var compatibleUnlockableItem: PickableItem?
    private(set) var tileMapPosition: Point
    private(set) var tileMapColision: [Point] = []
    private var actionType: InteractionType
    var nextScene: SKScene? = nil

    init(identifier: String, texture: SKTexture, position: Point, pickableItem: PickableItem?) {
        self.identifier = identifier
        self.tileMapPosition = position
        self.tileMapColision.append(tileMapPosition)
        self.storedPickableItem = pickableItem
        self.actionType = .PickItem
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    init(identifier: String, texture: SKTexture, position: Point, pickableItem: PickableItem?, unlockableItem: PickableItem?) {
        self.identifier = identifier
        self.tileMapPosition = position
        self.tileMapColision.append(tileMapPosition)
        self.storedPickableItem = pickableItem
        self.compatibleUnlockableItem = unlockableItem
        self.actionType = .UseItem
        super.init(texture: texture, color: .clear, size: texture.size())
    }

    init(identifier: String, texture: SKTexture, position: Point, nextScene: SKScene) {
        self.identifier = identifier
        self.tileMapPosition = position
        self.tileMapColision.append(tileMapPosition)
        self.nextScene = nextScene
        self.actionType = .ChangeRoom
        super.init(texture: texture, color: .clear, size: texture.size())
    }

    init(identifier: String, texture: SKTexture, position: Point, nextScene: SKScene, unlockableItem: PickableItem) {
        self.identifier = identifier
        self.tileMapPosition = position
        self.tileMapColision.append(tileMapPosition)
        self.nextScene = nextScene
        self.compatibleUnlockableItem = unlockableItem
        self.actionType = .UseItem
        super.init(texture: texture, color: .clear, size: texture.size())
        
    }
    
    init(identifier: String, texture: SKTexture, position: Point) {
        self.identifier = identifier
        self.tileMapPosition = position
        self.tileMapColision.append(tileMapPosition)
        self.actionType = .None
        super.init(texture: texture, color: .clear, size: texture.size())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func interact(with itemFromInventory: PickableItem) throws {
//        if compatiblePickableItems.contains(where: { element in
//            element.name == itemFromInventory.name
//        }) {
//            try itemFromInventory.use()
//        } else {
//            throw InteractibleItemError.incompatibleItem
//        }
//    }

    func interact() {
        print(actionType)
        switch actionType {
        case .PickItem:
                Inventory.shared.addItem(newItem: storedPickableItem!)

            print("===============")
            for item in Inventory.shared.items {
                print(item.name)
            }
            print("===============")
        case .UseItem:
            print("Usou:", compatibleUnlockableItem!.name)
            if compatibleUnlockableItem != nil && Inventory.shared.items.contains(where: {$0 == compatibleUnlockableItem}){
                do {try Inventory.shared.items.first(where: {$0 == compatibleUnlockableItem})!.use()}
                catch {
                    print(error)
                }
                compatibleUnlockableItem = nil
                if storedPickableItem != nil {
                    self.actionType = .PickItem
                }else if nextScene != nil {
                    self.actionType = .ChangeRoom
                }
            }
        case .ChangeRoom:
            let transition = SKTransition.fade(withDuration: 1)
            nextScene!.scaleMode = .resizeFill
//            (self.parent?.scene as! SceneProtocol).vc_reference!.presentScene(nextScene!, transition: transition)
            self.scene!.view!.presentScene(nextScene!, transition: transition)
        case .None:
            return
        }
    }

    func setCollisor(collision:Point) {
        self.tileMapColision.append(collision)
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
