//
//  GameViewController.swift
//  Feri
//
//  Created by Otávio Albuquerque on 03/04/23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    private lazy var interactButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ActionButton"), for: .normal)
        return button
    }()
    
    @objc func interact() {
        scene.hero.interactWithObject(on: scene.level)
    }
    let scene = GameScene()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(interactButton)
        
        NSLayoutConstraint.activate([
            interactButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            interactButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        interactButton.addTarget(self, action: #selector(interact), for: .touchUpInside)
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.

        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .resizeFill

        // Present the scene
        if let view = self.view as! SKView? {
            view.presentScene(scene)

            view.ignoresSiblingOrder = true

            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .landscape
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
