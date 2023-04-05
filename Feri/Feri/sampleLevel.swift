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
    var furnitureLayer: SKTileMapNode = SKTileMapNode()
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
        let bench = tileSet.tileGroups.first(where: {$0.name == "BancoChoco"})
        let toilet = tileSet.tileGroups.first(where: {$0.name == "VasoChoco"})
        floor.tileSet = tileSet
        floor.numberOfColumns = numOfColumns
        floor.numberOfRows = numOfRows
        floor.tileSize = tilesize
        furnitureLayer.tileSet = tileSet
        furnitureLayer.numberOfColumns = numOfColumns
        furnitureLayer.numberOfRows = numOfRows
        furnitureLayer.tileSize = tilesize
        
        map.addChild(floor)
        floor.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        floor.fill(with: whiteTiles)
        map.addChild(furnitureLayer)
        furnitureLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        furnitureLayer.position = CGPoint(x: 0, y: 7 )
        furnitureLayer.setTileGroup(toilet, forColumn: 5, row: 9)
        furnitureLayer.setTileGroup(bench, forColumn: 6, row: 9)
        
    }
    
    
    
}
