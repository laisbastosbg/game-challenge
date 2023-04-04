//
//  Hero.swift
//  Feri
//
//  Created by Otávio Albuquerque on 03/04/23.
//

import Foundation
import SpriteKit

typealias Point = (x: Int, y: Int)

class Hero: SKSpriteNode {
    var atlas = SKTextureAtlas(named: "Hero")

    var currentPosition: Point
    var hitbox: CGSize
    init(currentPosition: Point) {
        self.currentPosition = currentPosition
        let git  = CGSize(width: atlas.textureNamed(atlas.textureNames.first!).size().width/3, height: atlas.textureNamed(atlas.textureNames.first!).size().height/3)
        super.init(texture: atlas.textureNamed(atlas.textureNames.first!), color: .clear, size: atlas.textureNamed(atlas.textureNames.first!).size())
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveOnGrid(to position: Point, on map: SKTileMapNode) {
        print(position)
        let gridPosition = map.centerOfTile(atColumn: position.y, row: position.x)
        let moveAction =  SKAction.move(to: gridPosition, duration: 0.5)
        let animateAction = SKAction.animate(with: atlas.textureNames.map(SKTexture.init(imageNamed:)), timePerFrame: 0.2)
        self.run(moveAction)
        self.run(animateAction)
        
    }
}
