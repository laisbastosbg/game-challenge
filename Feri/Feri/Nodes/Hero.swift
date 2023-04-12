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
    private(set) var facingPosition: Point
    var hitbox: CGSize
    init(currentPosition: Point) {
        self.currentPosition = currentPosition
        self.facingPosition = currentPosition
        facingPosition.x -= 1
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
        
        
        if children.first(where: {$0.tileMapPosition == position}) == nil && position != currentPosition{
            var gridPosition = map.floor.centerOfTile(atColumn: position.y, row: position.x)
            gridPosition.y += self.size.height/3
            let moveAction =  SKAction.move(to: gridPosition, duration: 0.5)
            self.zPosition = CGFloat(position.y - position.x + map.numOfRows)
            self.run(moveAction)
            var animateAction: SKAction
            switch direction {
            case .TopLeft:
                animateAction = SKAction.animate(with: atlasBack.textureNames.map(SKTexture.init(imageNamed:)), timePerFrame: 0.1)
                self.xScale = 0.3
                self.run(animateAction)
                facingPosition = position
                facingPosition.y -= 1
            case .TopRight:
                animateAction = SKAction.animate(with: atlasBack.textureNames.map(SKTexture.init(imageNamed:)), timePerFrame: 0.1)
                self.xScale = -0.3
                self.run(animateAction)
                facingPosition = position
                facingPosition.x += 1
            case .DownLeft:
                animateAction = SKAction.animate(with: atlasFront.textureNames.map(SKTexture.init(imageNamed:)), timePerFrame: 0.1)
                self.xScale = 0.3
                self.run(animateAction)
                facingPosition = position
                facingPosition.x -= 1
            case .DownRight:
                animateAction = SKAction.animate(with: atlasFront.textureNames.map(SKTexture.init(imageNamed:)), timePerFrame: 0.1)
                self.xScale = -0.3
                self.run(animateAction)
                facingPosition = position
                facingPosition.y += 1
            case .None:
                break
            
            }
            self.currentPosition = position
        }else {
            switch direction {
            case .TopLeft:
                self.texture = atlasBack.textureNamed(atlasBack.textureNames.first!)
                self.xScale = 0.3
                facingPosition = currentPosition
                facingPosition.y -= 1
            case .TopRight:
                self.texture = atlasBack.textureNamed(atlasBack.textureNames.first!)
                self.xScale = -0.3
                facingPosition = currentPosition
                facingPosition.x += 1
            case .DownLeft:
                self.texture = atlasFront.textureNamed(atlasFront.textureNames.first!)
                self.xScale = 0.3
                facingPosition = currentPosition
                facingPosition.x -= 1
            case .DownRight:
                self.texture = atlasFront.textureNamed(atlasFront.textureNames.first!)
                self.xScale = -0.3
                facingPosition = currentPosition
                facingPosition.y += 1
            case .None:
                break
            }
        }

    }
    
    func interactWithObject(on map: levelMapProtocol) {
        print("oia")
        let objects = map.floor.children.map { obj in
            obj as! InteractibleItem
        }
        if let obj = objects.first(where: {$0.tileMapPosition == facingPosition}) {
            obj.interact()
        }
            
    }
    
}
