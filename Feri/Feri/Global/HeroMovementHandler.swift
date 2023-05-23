//
//  HeroMovementHandler.swift
//  Feri
//
//  Created by Lais Godinho on 23/05/23.
//

import Foundation

class HeroMovementHandler {
    static let shared = HeroMovementHandler()

    private init() {
        
    }

    func getValueOfNewPosition(touchLocation: CGPoint, oldPosition: Point, scene: SceneProtocol) -> Point {
        var newPosition = oldPosition
        if TouchHandler.shared.didTouchScreenTopLeftArea(touchLocation: touchLocation, cameraFrame: scene.myCamera.frame) {
            scene.touchLocation = .TopLeft
            if scene.hero.currentPosition.y > 0 {
                newPosition.y -= 1
            }
        } else if TouchHandler.shared.didTouchScreenTopRightArea(touchLocation: touchLocation, cameraFrame: scene.myCamera.frame) {
            scene.touchLocation = .TopRight
            if scene.hero.currentPosition.x < scene.level.numOfRows-1 {
                newPosition.x += 1
            }
        } else if TouchHandler.shared.didTouchScreenDownLeftArea(touchLocation: touchLocation, cameraFrame: scene.myCamera.frame) {
            scene.touchLocation = .DownLeft
            if scene.hero.currentPosition.x > 0 {
                newPosition.x -= 1
            }
        } else if TouchHandler.shared.didTouchScreenDownRightArea(touchLocation: touchLocation, cameraFrame: scene.myCamera.frame) {
            scene.touchLocation = .DownRight
            if scene.hero.currentPosition.y < scene.level.numOfColumns-1 {
                newPosition.y += 1
            }

        }
        return newPosition
    }
}
