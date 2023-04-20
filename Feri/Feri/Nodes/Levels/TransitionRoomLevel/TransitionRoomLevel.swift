//
//  TransitionRoomLevel.swift
//  Feri
//
//  Created by Lais Godinho on 12/04/23.
//

import Foundation
import SpriteKit

struct TransitionRoomLevel: levelMapProtocol {
    var numOfRows: Int
    var numOfColumns: Int
    var grid: [[String]]?
    var map: SKNode = SKNode()
    var floor: SKTileMapNode = SKTileMapNode()
    var leftWall: SKTileMapNode = SKTileMapNode()
    var rightWall: SKTileMapNode = SKTileMapNode()
    var heroInitialPosition: (x: Int, y: Int)

    func configLevel() {
            map.xScale = 1
            map.yScale = 1
            let tileSet = SKTileSet(named: "Chocolate")!
            let tilesize = CGSize(width: 64, height: 32)
            let tiles = tileSet.tileGroups.first(where: {$0.name == "RoseChoco"})

            floor.tileSet = tileSet
            floor.numberOfColumns = numOfColumns
            floor.numberOfRows = numOfRows
            floor.tileSize = tilesize
            map.addChild(floor)
            floor.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            floor.fill(with: tiles)

            generateFurniture()
    }

    func generateFurniture() {
        let door1 = InteractibleItem(identifier: "door1", texture: SKTexture(imageNamed: "TilePorta"), position: (x:5,y:12), nextScene: BedroomScene())
        insertDoorOnMap(object: door1, isColumnWall: false)

        let bedsideTable = InteractibleItem(identifier: "BedsideTable", texture: SKTexture(imageNamed: "bedside_table"), position: (x: 6, y: 8), nextScene: GameScene())
        insertOnMap(object: bedsideTable)

        let stairEnd = InteractibleItem(identifier: "stairEnd", texture: SKTexture(imageNamed: "StairEnd"), position: (x:2,y:2), nextScene: GameScene())
        insertOnMap(object: stairEnd, isColumnWall: true)

        let window = InteractibleItem(identifier: "window", texture: SKTexture(imageNamed: "TileJanela"), position: (x:3,y:0), nextScene: GameScene())
        insertDoorOnMap(object: window, isColumnWall: true)

        let door2 = InteractibleItem(identifier: "door2", texture: SKTexture(imageNamed: "TilePorta"), position: (x:5,y:3), nextScene: GameScene())
        insertDoorOnMap(object: door2, isColumnWall: false)
    }

    func insertOnMap(object: InteractibleItem, isColumnWall: Bool = false) {
        floor.addChild(object)
        object.position = floor.centerOfTile(atColumn: object.tileMapPosition.y, row: object.tileMapPosition.x)
        if isColumnWall {
            object.position.y += object.size.height/4
        } else {
            object.position.y += object.size.height/4
            object.xScale *= -1
        }
    }

    func insertDoorOnMap(object: InteractibleItem, isColumnWall: Bool, isSouthWall: Bool = false) {
        floor.addChild(object)
        print((floor.children.first! as! InteractibleItem).tileMapPosition)

        object.position = floor.centerOfTile(atColumn: object.tileMapPosition.y, row: object.tileMapPosition.x)
        object.position.y += object.size.height/3 + 8

        if isColumnWall {
            object.position.x -= 26
        } else {
            object.xScale *= -1
            object.position.x += 80
        }

        if isSouthWall {
            object.zPosition = 1
            object.position.x -= 114
        } else {
            object.zPosition = -1
        }
    }


}
