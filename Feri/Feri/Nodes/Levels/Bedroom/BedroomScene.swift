//
//  BedroomScene.swift
//  Feri
//
//  Created by Lais Godinho on 12/04/23.
//

import SpriteKit

class BedroomScene: SKScene, SceneProtocol {

    static var shared = BedroomScene()

    var touchLocation: TouchState = .None

    var level: levelMapProtocol = BedroomLevel(numOfRows: 5, numOfColumns: 5, heroInitialPosition: (x: 1, y: 2))

    lazy var hero: Hero = Hero(currentPosition: self.level.heroInitialPosition)

    var myCamera = SKCameraNode()

    var heroPosition: (x: Int, y: Int)?

    override func didMove(to view: SKView) {
        super.didMove(to: view)

        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        setupHero()
        let heroPosition = level.floor.centerOfTile(atColumn: hero.currentPosition.y, row: hero.currentPosition.x)

        hero.setPosition(position: heroPosition)
        setupLevelMap()
        setupCamera()
    }

    func setupHero() {
        if heroPosition != nil {
            self.hero = Hero(currentPosition: heroPosition!)
        }

        addChild(hero)

        hero.setScale(x: 0.3, y: 0.3)
    }

    func setupLevelMap() {
        addChild(level.map)
        level.configLevel()

        level.map.xScale = 1
        level.map.yScale = 1
    }

    func setupCamera() {
        addChild(myCamera)
        myCamera.position = hero.position
        myCamera.setScale(1)
        camera = myCamera
    }

    override func willMove(from view: SKView) {
        BedroomScene.shared.removeAllChildren()
    }

    func touchDown(atPoint pos : CGPoint) {
//        let location = pos
        let oldPosition: Point = hero.currentPosition

        let newPosition = HeroMovementHandler.shared.getValueOfNewPosition(touchLocation: pos, oldPosition: oldPosition, scene: self)
        hero.moveOnGrid(to: newPosition, on: level, direction: self.touchLocation)
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
