//
//  BathroomLevel.swift
//  Feri
//
//  Created by Lais Godinho on 24/04/23.
//

import SpriteKit

struct BathroomLevel: levelMapProtocol {
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
            generateWalls()
            alreadyLoaded = true
        }
    }

    func generateFurniture() {
        let transitionRoomDoor = InteractibleItem(identifier: "transitionRoomDoor", texture: SKTexture(imageNamed: "TilePorta"), position: (x:0,y:2), nextScene: TransitionRoomScene.shared)
        insertDoorOnMap(object: transitionRoomDoor, isColumnWall: false, isSouthWall: true)

        let plunger = PickableItem(name: "bathroomKey", remainingUses: 1, texture: SKTexture(imageNamed: "TileSet-chaveBanheiro"))
        //TODO: mudar asset
        let crowbar = PickableItem(name: "crowbar", remainingUses: 2, texture: SKTexture(imageNamed: "objetos"))
        let bathroomSink = InteractibleItem(identifier: "bathroomSink", texture: SKTexture(imageNamed: "TileSet-piaDoBanheiro"), position: (x: 3, y: 3), pickableItem: plunger, unlockableItem: crowbar)
        insertOnMap(object: bathroomSink)

        let storageKey = PickableItem(name: "storageKey", remainingUses: 1, texture: SKTexture(imageNamed: "TileSet-chave"))
        let toilet = InteractibleItem(identifier: "toilet", texture: SKTexture(imageNamed: "TileSet-vasoSujo"), position: (x: 2, y: 0), pickableItem: storageKey, unlockableItem: plunger)
        insertOnMap(object: toilet, isColumnWall: false)
    }
    
    func generateWalls() {
        for i in 0..<numOfRows {
            let wall = Wall(texture: SKTexture(imageNamed: "TileSet-Pare"), position: (x:i,y:0))
            insertWallOnMap(object: wall, isColumnWall: true)

        }
        for i in 0..<numOfColumns {
            let wall = Wall(texture: SKTexture(imageNamed: "TileSet-Pare"), position: (x:numOfRows-1,y:i))
            insertWallOnMap(object: wall, isColumnWall: false)

        }
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
    
    func insertWallOnMap(object: Wall, isColumnWall: Bool) {
        floor.addChild(object)
        object.xScale = 1.2
        object.yScale = 1

        object.position = floor.centerOfTile(atColumn: object.tileMapPosition.y, row: object.tileMapPosition.x)
        object.position.y += object.size.height/3 + 18

        if isColumnWall {
            object.zPosition = CGFloat(numOfRows - object.tileMapPosition.x) - 5
            object.position.x -= 32
        } else {
            object.zPosition = CGFloat( object.tileMapPosition.y) - 5
            object.xScale *= -1
            object.position.x += 32
        }
        print(object.tileMapPosition, object.zPosition)


    }
}
