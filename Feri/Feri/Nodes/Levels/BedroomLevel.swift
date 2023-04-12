//
//  BedroomLevel.swift
//  Feri
//
//  Created by Lais Godinho on 11/04/23.
//

import Foundation
import SpriteKit

struct BedroomLevel: levelMapProtocol {
    var numOfRows: Int
    var numOfColumns: Int
    var grid: [[String]]?
    var map: SKNode = SKNode()
    var floor: SKTileMapNode = SKTileMapNode()
    var leftWall: SKTileMapNode = SKTileMapNode()
    var rightWall: SKTileMapNode = SKTileMapNode()
    var heroInitialPosition: (x:Int,y:Int)

    func configLevel() {
        map.xScale = 1
        map.yScale = 1
        let tileSet = SKTileSet(named: "Chocolate")!
        let tilesize = CGSize(width: 64, height: 32)
        let tiles = tileSet.tileGroups.first(where: {$0.name == "BlackChoco"})

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
        let door1 = InteractibleItem(identifier: "door1", texture: SKTexture(imageNamed: "TilePorta"), position: (x:9,y:3), nextScene: GameScene())
        insertDoorOnMap(object: door1, isColumnWall: false)

        let bedsideTable = InteractibleItem(identifier: "BedsideTable", texture: SKTexture(imageNamed: "bedside_table"), position: (x: 10, y: 0), nextScene: GameScene())
        insertOnMap(object: bedsideTable)

        let bed = InteractibleItem(identifier: "bed", texture: SKTexture(imageNamed: "TileSet-cama"), position: (x: 6, y: 8), nextScene: GameScene())
        insertOnMap(object: bed)

        let storage = InteractibleItem(identifier: "storage", texture: SKTexture(imageNamed: "storage"), position: (x: 2, y: 0), nextScene: GameScene())
        insertOnMap(object: storage)

        let shelf = InteractibleItem(identifier: "shelf", texture: SKTexture(imageNamed: "TileSet-shelf"), position: (x: 0, y: 3), nextScene: GameScene())
        insertOnMap(object: shelf, isColumnWall: false)

        let door2 = InteractibleItem(identifier: "door2", texture: SKTexture(imageNamed: "TilePorta"), position: (x:0,y:9), nextScene: GameScene())
        insertDoorOnMap(object: door2, isColumnWall: false, isSouthWall: true)

    }

    func insertOnMap(object: InteractibleItem, isColumnWall: Bool = true) {
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
