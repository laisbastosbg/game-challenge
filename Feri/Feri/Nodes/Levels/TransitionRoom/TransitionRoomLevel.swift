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
    var alreadyLoaded = false
    mutating func configLevel() {
            map.xScale = 1
            map.yScale = 1
            let tileSet = SKTileSet(named: "Chocolate")!
            let tilesize = CGSize(width: 128, height: 64)
            let tiles = tileSet.tileGroups.first(where: {$0.name == "RoseChoco"})

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
        let bedroomDoor = WorldInteractibleItems.shared.getInteractibleItem(name: "transitionRoomToBedroomDoor")
        insertDoorOnMap(object: bedroomDoor, isColumnWall: false)

        let transitionRoomTable = WorldInteractibleItems.shared.getInteractibleItem(name: "transitionRoomTable")
        insertOnMap(object: transitionRoomTable)

        let stairEnd = WorldInteractibleItems.shared.getInteractibleItem(name: "stairEnd")
        insertOnMap(object: stairEnd, isColumnWall: true)

        let window = WorldInteractibleItems.shared.getInteractibleItem(name: "window")
        insertDoorOnMap(object: window, isColumnWall: true)

        BathroomScene.shared.heroPosition = (x: 1, y: 0)
        let bathroomDoor = WorldInteractibleItems.shared.getInteractibleItem(name: "transitionRoomToBathroomDoor")
        insertDoorOnMap(object: bathroomDoor, isColumnWall: false)
    }
    
    func generateWalls() {
        for i in 0..<numOfRows {
            let wall = Wall(texture: SKTexture(imageNamed: "wall-darkColor"), position: (x:i,y:0))
            insertWallOnMap(object: wall, isColumnWall: true)

        }
        for i in 0..<numOfColumns {
            let wall = Wall(texture: SKTexture(imageNamed: "wall-mediumColor"), position: (x:numOfRows-1,y:i))
            insertWallOnMap(object: wall, isColumnWall: false)

        }
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
        object.xScale = 1
        object.yScale = 1

        object.position = floor.centerOfTile(atColumn: object.tileMapPosition.y, row: object.tileMapPosition.x)
        object.position.y += object.size.height/3 + 18

        if isColumnWall {
            object.zPosition = CGFloat(-object.tileMapPosition.x - numOfRows) 
            object.position.x -= 32
        } else {
            object.zPosition = CGFloat( object.tileMapPosition.y - numOfColumns)
            object.xScale *= -1
            object.position.x += 32
        }
        print(object.tileMapPosition, object.zPosition)


    }


}
