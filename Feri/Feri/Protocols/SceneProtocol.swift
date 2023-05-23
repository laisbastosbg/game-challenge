//
//  SceneProtocol.swift
//  Feri
//
//  Created by Otávio Albuquerque on 24/04/23.
//

import Foundation
import SpriteKit


protocol SceneProtocol: class {
    var hero: Hero { get set }
    var level: levelMapProtocol { get }
    var touchLocation: TouchState { get set }
    var myCamera: SKCameraNode { get set }
}
