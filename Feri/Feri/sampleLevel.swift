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
    var heroInitialPosition: SIMD2<Int>

    func configLevel() {
        map.xScale = 1
        map.yScale = 1
        let tileSet = SKTileSet(named: "Sample Isometric Tile Set")!
        let tilesize = CGSize(width: 128, height: 64)
        let grassTiles = tileSet.tileGroups.first(where: {$0.name == "Grass"})
        _ = tileSet.tileGroups.first(where: {$0.name == "Sand"})
        floor.tileSet = tileSet
        floor.numberOfColumns = numOfColumns
        floor.numberOfRows = numOfRows
        floor.tileSize = tilesize
        
        map.addChild(floor)
        floor.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        floor.fill(with: grassTiles)
    }
    
    
    
}
