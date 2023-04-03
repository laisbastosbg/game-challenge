//
//  GameScene.swift
//  Feri
//
//  Created by Otávio Albuquerque on 03/04/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var touchLocation: TouchState = .None

    let level = sampleLevel(numOfRows: 10, numOfColumns: 10, heroInitialPosition: SIMD2<Int>.init(x: 3, y: 3))
    
    var hero: Hero {
        return Hero(positition: level.heroInitialPosition)
    }
    var myCamera = SKCameraNode()
    
    override func didMove(to view: SKView) {

        addChild(level.map)
        level.configLevel()
        level.map.xScale = 2
        level.map.yScale = 2
        level.map.scene?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        hero.xScale = 0.5
        hero.yScale = 0.5
        addChild(hero)
        print(level.floor.centerOfTile(atColumn: hero.positition.y, row: hero.positition.x))
        hero.position = level.floor.centerOfTile(atColumn: hero.positition.y, row: hero.positition.x)
        myCamera.position = hero.position
        myCamera.setScale(2)
        addChild(myCamera)
        camera = myCamera

    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        let location = pos
        if location.x < CGRectGetMidX(self.frame) && location.y > CGRectGetMidY(self.frame) {
            self.touchLocation = .TopLeft
            print("UpLeft")
        } else if location.x > CGRectGetMidX(self.frame) && location.y > CGRectGetMidY(self.frame) {
            self.touchLocation = .TopRight
            print("UpRight")
        } else if location.x < CGRectGetMidX(self.frame) && location.y < CGRectGetMidY(self.frame) {
            self.touchLocation = .DownLeft
            print("DownLeft")
            let zoomInAction = SKAction.scale(to: 2, duration: 1)
            myCamera.run(zoomInAction)
        } else if location.x > CGRectGetMidX(self.frame) && location.y < CGRectGetMidY(self.frame) {
            self.touchLocation = .DownRight
            print("DownRight")
            let zoomInAction = SKAction.scale(to: 0.5, duration: 1)
            myCamera.run(zoomInAction)

        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        camera?.position = hero.position
    }
}
