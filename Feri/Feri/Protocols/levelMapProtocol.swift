//
//  MapLevelProtocol.swift
//  Feri
//
//  Created by Otávio Albuquerque on 03/04/23.
//

import Foundation
import SpriteKit

protocol levelMapProtocol {
    var numOfRows: Int {get set}
    var numOfColumns: Int {get set}
    var map: SKNode { get }
    var floor: SKTileMapNode { get }
    var leftWall: SKTileMapNode { get }
    var rightWall: SKTileMapNode { get }
    var heroInitialPosition: (x: Int, y: Int) { get }

    mutating func configLevel()
    func generateFurniture()
    func insertOnMap(object: InteractibleItem, isColumnWall: Bool)
    func insertDoorOnMap(object: InteractibleItem, isColumnWall: Bool, isSouthWall: Bool)
}
