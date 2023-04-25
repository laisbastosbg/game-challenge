//
//  BathroomScene.swift
//  Feri
//
//  Created by Lais Godinho on 24/04/23.
//

import SpriteKit

class BathroomScene: SKScene, SceneProtocol {

    static var shared = BathroomScene()
    static var description = "BathroomScene"

    var touchLocation: TouchState = .None

    var level: levelMapProtocol = BathroomLevel(numOfRows: 5, numOfColumns: 3, heroInitialPosition: (x: 0, y: 2))

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
        hero.position = level.floor.centerOfTile(atColumn: hero.currentPosition.y, row: hero.currentPosition.x)
        print(hero.frame.minY)
        hero.position.y += hero.size.height/3
        myCamera.position = hero.position
        myCamera.setScale(1)
        addChild(myCamera)
        camera = myCamera

    }
    override func willMove(from view: SKView) {
        BathroomScene.shared.removeAllChildren()
    }


    func touchDown(atPoint pos : CGPoint) {
        let location = pos
        var coordinate: Point = hero.currentPosition
        if location.x < CGRectGetMidX(myCamera.frame) && location.y > CGRectGetMidY(myCamera.frame) {
            self.touchLocation = .TopLeft
            if hero.currentPosition.y > 0 {
                coordinate.y -= 1
            }
            hero.moveOnGrid(to: coordinate, on: level, direction: self.touchLocation)
        } else if location.x > CGRectGetMidX(myCamera.frame) && location.y > CGRectGetMidY(myCamera.frame) {
            self.touchLocation = .TopRight
            if hero.currentPosition.x < level.numOfRows-1 {
                coordinate.x += 1
            }
            hero.moveOnGrid(to: coordinate, on: level, direction: self.touchLocation)
        } else if location.x < CGRectGetMidX(myCamera.frame) && location.y < CGRectGetMidY(myCamera.frame) {
            self.touchLocation = .DownLeft
            if hero.currentPosition.x > 0 {
                coordinate.x -= 1
            }
            hero.moveOnGrid(to: coordinate, on: level, direction: self.touchLocation)
        } else if location.x > CGRectGetMidX(myCamera.frame) && location.y < CGRectGetMidY(myCamera.frame) {
            self.touchLocation = .DownRight
            if hero.currentPosition.y < level.numOfColumns-1 {
                coordinate.y += 1
            }
            hero.moveOnGrid(to: coordinate, on: level, direction: self.touchLocation)


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

