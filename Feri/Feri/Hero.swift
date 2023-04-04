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
    
    var atlasFront = SKTextureAtlas(named: "HeroFront")
    var atlasBack = SKTextureAtlas(named: "HeroBack")
    var currentPosition: Point
    var hitbox: CGSize
    init(currentPosition: Point) {
        self.currentPosition = currentPosition
        self.hitbox = CGSize(width: atlasFront.textureNamed(atlasFront.textureNames.first!).size().width, height: atlasFront.textureNamed(atlasFront.textureNames.first!).size().height/4)
        super.init(texture: atlasFront.textureNamed(atlasFront.textureNames.first!), color: .clear, size: atlasFront.textureNamed(atlasFront.textureNames.first!).size())
        self.physicsBody = SKPhysicsBody(rectangleOf: hitbox)
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.node?.position = CGPoint(x: self.frame.midX, y: self.frame.minY)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveOnGrid(to position: Point, on map: SKTileMapNode, direction: TouchState) {
        print(position)
        let gridPosition = map.centerOfTile(atColumn: position.y, row: position.x)
        let moveAction =  SKAction.move(to: gridPosition, duration: 0.5)
        self.run(moveAction)
        switch direction {
        case .TopLeft:
            let animateAction = SKAction.animate(with: atlasBack.textureNames.map(SKTexture.init(imageNamed:)), timePerFrame: 0.2)
            self.xScale = 0.3
            self.run(animateAction)
        case .TopRight:
            let animateAction = SKAction.animate(with: atlasBack.textureNames.map(SKTexture.init(imageNamed:)), timePerFrame: 0.2)
            self.xScale = -0.3
            self.run(animateAction)
        case .DownLeft:
            let animateAction = SKAction.animate(with: atlasFront.textureNames.map(SKTexture.init(imageNamed:)), timePerFrame: 0.2)
            self.xScale = 0.3
            self.run(animateAction)
        case .DownRight:
            let animateAction = SKAction.animate(with: atlasFront.textureNames.map(SKTexture.init(imageNamed:)), timePerFrame: 0.2)
            self.xScale = -0.3
            self.run(animateAction)
        case .None:
            break
        }
    }
}
