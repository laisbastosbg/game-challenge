//
//  sampleLevel.swift
//  Feri
//
//  Created by Otávio Albuquerque on 03/04/23.
//

import Foundation
import SpriteKit

struct sampleLevel: levelMapProtocol {

    
    
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
        let tilesize = CGSize(width: 128, height: 64)
        let whiteTiles = tileSet.tileGroups.first(where: {$0.name == "WhiteChoco"})
        let blackTiles = tileSet.tileGroups.first(where: {$0.name == "BlackChoco"})
        let roseTiles = tileSet.tileGroups.first(where: {$0.name == "RoseChoco"})

        floor.tileSet = tileSet
        floor.numberOfColumns = numOfColumns
        floor.numberOfRows = numOfRows
        floor.tileSize = tilesize
        map.addChild(floor)
        floor.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        floor.fill(with: blackTiles)
        floor.setTileGroup(whiteTiles, forColumn: 1, row: 1)
        generateFurniture()
    }

    func generateFurniture() {
        let vaso = InteractibleItem(identifier: "Vaso", texture: SKTexture(imageNamed: "TileSet-Vaso"), position: (x:9,y:9), nextScene: GameScene())
        insertOnMap(object: vaso)

        let porta = InteractibleItem(identifier: "Porta", texture: SKTexture(imageNamed: "TilePorta"), position: (x:5,y:0), nextScene: GameScene())
        insertDoorOnMap(object: porta, isColumnWall: true)
        
        let keyChest = PickableItem(name: "ChaveBau", remainingUses: 1, texture: SKTexture(imageNamed: "TileSet-chave"))
        let keyDoor = PickableItem(name: "ChavePorta", remainingUses: 1, texture: SKTexture(imageNamed: "TileSet-chave"))
        
        let bau = InteractibleItem(identifier: "Bau", texture: SKTexture(imageNamed: "TilseSet-storage"), position: (x:1,y:1), pickableItem: keyDoor, unlockableItem: keyChest)
        insertOnMap(object: bau)
        let escada = InteractibleItem(identifier: "StairEnd", texture: SKTexture(imageNamed: "StairEnd"), position: (x:7,y:5), nextScene: GameScene())
        insertOnMap(object: escada)
        escada.zPosition = 0
    }

    func insertOnMap(object: InteractibleItem, isColumnWall: Bool = true) {
        floor.addChild(object)
        object.position = floor.centerOfTile(atColumn: object.tileMapPosition.y, row: object.tileMapPosition.x)
        object.position.y += object.size.height/4
        if !isColumnWall {
            object.xScale *= -1
        }
        object.zPosition = CGFloat(object.tileMapPosition.y + object.tileMapPosition.x)
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
            object.zPosition = CGFloat(object.tileMapPosition.y) + 1
            object.position.x -= 114
        } else {
            object.zPosition = -1
        }
    }
    
}
