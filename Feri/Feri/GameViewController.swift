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
import SwiftUI

class GameViewController: UIViewController {
    
    private lazy var interactButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "Botao-Pegar"), for: .normal)
        return button
    }()
    private lazy var inventoryButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "ActionButton"), for: .normal)
        return button
    }()


    lazy var InventoryView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named:"UI-Inventario")!)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var inventoryElements: UIView = {
        let vc = UIHostingController(rootView: Feri.InventoryView(inventoryItems: Inventory.shared))
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.backgroundColor = .clear
        return vc.view
    }()
    
    

    let overlayView: UIView = UIHostingConfiguration {
        RadialGradient(colors: [.clear, .black], center: .center, startRadius: 0, endRadius: 300)
            .ignoresSafeArea()
    }

    .margins(.all, 0)
    .makeContentView()


    
    var myView: SKView!
    var scene = BedroomScene.shared
//    var scene = OutsideScene.shared
    
    
    @objc func interact() {
        (myView.scene as! any SceneProtocol).hero.interactWithObject(on: (myView.scene as! any SceneProtocol).level)
    }
    
    @objc func openInventory() {
        InventoryView.isHidden.toggle()
    }


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
        view.addSubview(inventoryButton)
        
        NSLayoutConstraint.activate([
            interactButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            interactButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            interactButton.widthAnchor.constraint(equalToConstant: 70),
            interactButton.heightAnchor.constraint(equalToConstant: 70),
            
            inventoryButton.bottomAnchor.constraint(equalTo: interactButton.topAnchor,constant: -40),
            inventoryButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40)
        ])
        view.addSubview(InventoryView)
        InventoryView.addSubview(inventoryElements)


        NSLayoutConstraint.activate([
            InventoryView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            InventoryView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            InventoryView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 150),
            InventoryView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -150),
            
            inventoryElements.topAnchor.constraint(equalTo: InventoryView.topAnchor, constant: 10),
            inventoryElements.bottomAnchor.constraint(equalTo: InventoryView.bottomAnchor, constant: -10),
            inventoryElements.leftAnchor.constraint(equalTo: InventoryView.leftAnchor, constant: 10),
            inventoryElements.rightAnchor.constraint(equalTo: InventoryView.rightAnchor, constant: -10),
            inventoryElements.centerXAnchor.constraint(equalTo: InventoryView.centerXAnchor),
            inventoryElements.centerYAnchor.constraint(equalTo: InventoryView.centerYAnchor)


        ])
        
        self.InventoryView.isHidden = true
        
        interactButton.addTarget(self, action: #selector(interact), for: .touchUpInside)
        inventoryButton.addTarget(self, action: #selector(openInventory), for: .touchUpInside)
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
