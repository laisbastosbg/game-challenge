//
//  GameViewController.swift
//  Feri
//
//  Created by Otávio Albuquerque on 03/04/23.
//

import UIKit
import SwiftUI
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    
    
    private lazy var interactButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ActionButton"), for: .normal)
        return button
    }()
    
    private lazy var DPad: UIView = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ActionButton"), for: .normal)
        return button
    }()

    let overlayView: UIView = UIHostingConfiguration {
        RadialGradient(colors: [.clear, .black], center: .center, startRadius: 0, endRadius: 300)
            .ignoresSafeArea()
    }

    .margins(.all, 0)
    .makeContentView()

    
    var myView: SKView!
    var scene = BedroomScene.shared
    
    
    @objc func interact() {
        (myView.scene as! any SceneProtocol).hero.interactWithObject(on: (myView.scene as! any SceneProtocol).level)
    }

//    let scene = GameScene(level: TransitionRoomLevel(numOfRows: 3, numOfColumns: 8, heroInitialPosition: (x: 2, y: 6)))
//    let scene = BathroomScene.shared
//    let scene = TransitionRoomScene.shared
    override func viewDidLoad() {
        super.viewDidLoad()

        overlayView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(overlayView)

        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: view.topAnchor),
            overlayView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            overlayView.leftAnchor.constraint(equalTo: view.leftAnchor),
            overlayView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])

        view.addSubview(interactButton)
        
        NSLayoutConstraint.activate([
            interactButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            interactButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])
        
        interactButton.addTarget(self, action: #selector(interact), for: .touchUpInside)
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        
        
        // Set the scale mode to scale to fit the window
        scene.scaleMode = .resizeFill
        
        // Present the scene
        myView = self.view as! SKView?
        myView.presentScene(scene)
        
        myView.ignoresSiblingOrder = true
        
        myView.showsFPS = true
        myView.showsNodeCount = true
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        gradient.frame = view.bounds
//        view.layer.addSublayer(gradient)
    }
    
    func presentView(scene: SKScene) {
        myView.presentScene(scene, transition: SKTransition.fade(withDuration: 0.5))
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
