//
//  Wall.swift
//  Feri
//
//  Created by Otávio Albuquerque on 25/04/23.
//

import Foundation
//
//  InteractibleItem.swift
//  Feri
//
//  Created by Lais Godinho on 04/04/23.
//

import Foundation
import SpriteKit


class Wall: SKSpriteNode{
    


    private(set) var tileMapPosition: Point
    var nextScene: SKScene? = nil



 
    
    init(texture: SKTexture, position: Point) {
        self.tileMapPosition = position
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



}
