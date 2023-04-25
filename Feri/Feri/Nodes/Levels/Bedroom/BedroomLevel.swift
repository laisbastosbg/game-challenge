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
    var alreadyLoaded = false
    mutating func configLevel() {
        

        map.xScale = 1
        map.yScale = 1
        let tileSet = SKTileSet(named: "Chocolate")!
        let tilesize = CGSize(width: 128, height: 64)
        let tiles = tileSet.tileGroups.first(where: {$0.name == "BlackChoco"})

        floor.tileSet = tileSet
        floor.numberOfColumns = numOfColumns
        floor.numberOfRows = numOfRows
        floor.tileSize = tilesize

        floor.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        floor.fill(with: tiles)
        if !alreadyLoaded{
            map.addChild(floor)
            generateFurniture()
            alreadyLoaded = true
        }


    }

    func generateFurniture() {
        let balconyKey = WorldItems.shared.getItem(name: "balconyKey")
        let balconyDoor = InteractibleItem(identifier: "balconyDoor", texture: SKTexture(imageNamed: "TilePorta"), position: (x:4,y:2), nextScene: BathroomScene.shared, unlockableItem: balconyKey)
        insertDoorOnMap(object: balconyDoor, isColumnWall: false)

        let bathroomKey = WorldItems.shared.getItem(name: "bathroomKey")
        let bedsideTable = InteractibleItem(identifier: "BedsideTable", texture: SKTexture(imageNamed: "bedside_table"), position: (x: 4, y: 0), pickableItem: bathroomKey)
        insertOnMap(object: bedsideTable)

        //TODO: mudar asset
        let crowbar = WorldItems.shared.getItem(name: "crowbar")
        let lantern = WorldItems.shared.getItem(name: "lantern")
        let bed = InteractibleItem(identifier: "bed", texture: SKTexture(imageNamed: "TileSet-cama"), position: (x: 2, y: 4), pickableItem: crowbar, unlockableItem: lantern)
        insertOnMap(object: bed)
        bed.setCollisor(collision: (x:3,y:4))

        let ropes = WorldItems.shared.getItem(name: "ropes")
        let storage = InteractibleItem(identifier: "storage", texture: SKTexture(imageNamed: "storage"), position: (x: 1, y: 0), pickableItem: ropes)
        insertOnMap(object: storage)

        let shelf = InteractibleItem(identifier: "shelf", texture: SKTexture(imageNamed: "TileSet-shelf"), position: (x: 0, y: 1), pickableItem: lantern)
        insertOnMap(object: shelf, isColumnWall: false)

        let transitionRoomDoor = InteractibleItem(identifier: "transitionRoomDoor", texture: SKTexture(imageNamed: "TilePorta"), position: (x:0,y:4), nextScene: TransitionRoomScene.shared)
        insertDoorOnMap(object: transitionRoomDoor, isColumnWall: false, isSouthWall: true)

    }

    func insertOnMap(object: InteractibleItem, isColumnWall: Bool = true) {
        floor.addChild(object)
        object.position = floor.centerOfTile(atColumn: object.tileMapPosition.y, row: object.tileMapPosition.x)
        object.zPosition = CGFloat(object.tileMapPosition.y - object.tileMapPosition.x + numOfRows)
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
            object.position.x += 26
        }

        if isSouthWall {
           object.position.y -= 30
            object.zPosition = CGFloat(object.tileMapPosition.y - object.tileMapPosition.x + numOfRows) + 1
            object.position.x -= 70
        } else {
            object.zPosition = -1
        }
    }
}
