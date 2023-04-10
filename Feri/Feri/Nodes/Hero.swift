//
//  Hero.swift
//  Feri
//
//  Created by Otávio Albuquerque on 03/04/23.
//

import Foundation
import SpriteKit



class Hero: SKSpriteNode {
    
    var atlasFront = SKTextureAtlas(named: "HeroFrontTest")
    var atlasBack = SKTextureAtlas(named: "HeroBackTest")
    private(set) var currentPosition: Point
    var hitbox: CGSize
    init(currentPosition: Point) {
        self.currentPosition = currentPosition
        self.hitbox = CGSize(width: atlasFront.textureNamed(atlasFront.textureNames.first!).size().width, height: atlasFront.textureNamed(atlasFront.textureNames.first!).size().height/4)
        super.init(texture: atlasFront.textureNamed(atlasFront.textureNames[0]), color: .clear, size: atlasFront.textureNamed(atlasFront.textureNames[0]).size())
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveOnGrid(to position: Point, on map: levelMapProtocol, direction: TouchState) {
        let children = map.floor.children.map { child in
            child as! InteractibleItem
        }
        print(children.first!.tileMapPosition)
        if children.first(where: {$0.tileMapPosition == position}) == nil {
            var gridPosition = map.floor.centerOfTile(atColumn: position.y, row: position.x)
            gridPosition.y += self.size.height/3
            let moveAction =  SKAction.move(to: gridPosition, duration: 0.5)
            print(position)
            self.run(moveAction)
            var animateAction: SKAction
            switch direction {
            case .TopLeft:
                animateAction = SKAction.animate(with: atlasBack.textureNames.map(SKTexture.init(imageNamed:)), timePerFrame: 0.1)
                self.xScale = 0.3
                self.run(animateAction)
            case .TopRight:
                animateAction = SKAction.animate(with: atlasBack.textureNames.map(SKTexture.init(imageNamed:)), timePerFrame: 0.1)
                self.xScale = -0.3
                self.run(animateAction)
            case .DownLeft:
                animateAction = SKAction.animate(with: atlasFront.textureNames.map(SKTexture.init(imageNamed:)), timePerFrame: 0.1)
                self.xScale = 0.3
                self.run(animateAction)
            case .DownRight:
                animateAction = SKAction.animate(with: atlasFront.textureNames.map(SKTexture.init(imageNamed:)), timePerFrame: 0.1)
                self.xScale = -0.3
                self.run(animateAction)
            case .None:
                break
            
            }
            self.currentPosition = position
        }
        

    }
    
    func interactWith(object: InteractibleItem) {
        if object.compatiblePickableItems != nil {
            
        }
            
    }
    
}
