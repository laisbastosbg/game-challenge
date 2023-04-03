//
//  Hero.swift
//  Feri
//
//  Created by Otávio Albuquerque on 03/04/23.
//

import Foundation
import SpriteKit
class Hero: SKNode {
    var atlas = SKTextureAtlas(named: "Hero")
    var sprite: SKSpriteNode {
        return SKSpriteNode(texture: self.atlas.textureNamed(self.atlas.textureNames.first!))
    }

    var positition: SIMD2<Int>
    
    init(positition: SIMD2<Int>){
        self.positition = positition
        super.init()
        self.addChild(sprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveOnGrid(to position: SIMD2<Int>) {
        
        
        
    }
}
