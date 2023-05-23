//
//  TouchHandler.swift
//  Feri
//
//  Created by Lais Godinho on 23/05/23.
//

import SpriteKit

class TouchHandler {
    static let shared = TouchHandler()

    private init() {

    }

    func didTouchScreenTopLeftArea(touchLocation: CGPoint, cameraFrame: CGRect) -> Bool {
        if touchLocation.x < CGRectGetMidX(cameraFrame) && touchLocation.y > CGRectGetMidY(cameraFrame) {
            return true
        }
        return false
    }

    func didTouchScreenTopRightArea(touchLocation: CGPoint, cameraFrame: CGRect) -> Bool {
        if touchLocation.x > CGRectGetMidX(cameraFrame) && touchLocation.y > CGRectGetMidY(cameraFrame) {
            return true
        }
        return false
    }

    func didTouchScreenDownLeftArea(touchLocation: CGPoint, cameraFrame: CGRect) -> Bool {
        if touchLocation.x < CGRectGetMidX(cameraFrame) && touchLocation.y < CGRectGetMidY(cameraFrame) {
            return true
        }
        return false
    }

    func didTouchScreenDownRightArea(touchLocation: CGPoint, cameraFrame: CGRect) -> Bool {
        if touchLocation.x > CGRectGetMidX(cameraFrame) && touchLocation.y < CGRectGetMidY(cameraFrame) {
            return true
        }
        return false
    }
}
