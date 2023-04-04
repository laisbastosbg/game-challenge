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

    let level = sampleLevel(numOfRows: 10, numOfColumns: 10, heroInitialPosition: (x: 3, y: 3))
    
    lazy var hero: Hero = Hero(currentPosition: self.level.heroInitialPosition)
    
    var myCamera = SKCameraNode()
    
    override func didMove(to view: SKView) {

        addChild(level.map)
        level.configLevel()
        level.map.xScale = 1
        level.map.yScale = 1
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        hero.xScale = 0.3
        hero.yScale = 0.3
        addChild(hero)
        print(level.floor.centerOfTile(atColumn: hero.currentPosition.y, row: hero.currentPosition.x))
        hero.position = level.floor.centerOfTile(atColumn: hero.currentPosition.y, row: hero.currentPosition.x)
        myCamera.position = hero.position
        myCamera.setScale(1)
        addChild(myCamera)
        camera = myCamera

    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        let location = pos
        if location.x < CGRectGetMidX(myCamera.frame) && location.y > CGRectGetMidY(myCamera.frame) {
            self.touchLocation = .TopLeft
            print("UpLeft")
            if hero.currentPosition.y > 0 {
                hero.currentPosition.y -= 1
            }
            hero.moveOnGrid(to: hero.currentPosition, on: level.floor)
        } else if location.x > CGRectGetMidX(myCamera.frame) && location.y > CGRectGetMidY(myCamera.frame) {
            self.touchLocation = .TopRight
            if hero.currentPosition.x < level.numOfRows {
                hero.currentPosition.x += 1
            }
            hero.moveOnGrid(to: hero.currentPosition, on: level.floor)
            print("UpRight")
        } else if location.x < CGRectGetMidX(myCamera.frame) && location.y < CGRectGetMidY(myCamera.frame) {
            self.touchLocation = .DownLeft
            if hero.currentPosition.x > 0 {
                hero.currentPosition.x -= 1
            }
            hero.moveOnGrid(to: hero.currentPosition, on: level.floor)
            print("DownLeft")
        } else if location.x > CGRectGetMidX(myCamera.frame) && location.y < CGRectGetMidY(myCamera.frame) {
            self.touchLocation = .DownRight
            if hero.currentPosition.y < level.numOfColumns {
                hero.currentPosition.y += 1
            }
            hero.moveOnGrid(to: hero.currentPosition, on: level.floor)
            print("DownRight")

        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {
        self.touchLocation = .None
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
