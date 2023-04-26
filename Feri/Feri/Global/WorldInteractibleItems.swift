//
//  WorldInteractibleItems.swift
//  Feri
//
//  Created by Lais Godinho on 26/04/23.
//

import Foundation
import SpriteKit

class WorldInteractibleItems {
    static var shared = WorldInteractibleItems()
    var items: [InteractibleItem] = []

    private init() {
        items = generateInteractibleItems()
        print("b")
    }

    func getInteractibleItem(name: String) -> InteractibleItem {
        print(">>>>> \(name)")
        let items = WorldInteractibleItems.shared.items.filter { $0.identifier == name}
        guard let item = items.first else {

            fatalError()
        }

        return item
    }

    func generateInteractibleItems() -> [InteractibleItem] {
        let plunger = WorldPickableItems.shared.getPickableItem(name: "plunger")
        let crowbar = WorldPickableItems.shared.getPickableItem(name: "crowbar")
        let storageKey = WorldPickableItems.shared.getPickableItem(name: "storageKey")
        let balconyKey = WorldPickableItems.shared.getPickableItem(name: "balconyKey")
        let bathroomKey = WorldPickableItems.shared.getPickableItem(name: "bathroomKey")
        let lantern = WorldPickableItems.shared.getPickableItem(name: "lantern")
        let ropes = WorldPickableItems.shared.getPickableItem(name: "ropes")
        let pickableStool = WorldPickableItems.shared.getPickableItem(name: "stool")

        // Bathroom furniture

        let bathroomToTransitionRoomDoor = InteractibleItem(identifier: "bathroomToTransitionRoomDoor", texture: SKTexture(imageNamed: "porta_fechada"), unlockedTexture: SKTexture(imageNamed: "porta_aberta"), position: (x:0,y:1), nextScene: TransitionRoomScene.shared)

        let bathroomSink = InteractibleItem(identifier: "bathroomSink", texture: SKTexture(imageNamed: "TileSet-piaBanheiroFechada"), unlockedTexture: SKTexture(imageNamed: "TileSet-piaBanheiroAberta"), position: (x: 4, y: 2), pickableItem: plunger, unlockableItem: crowbar)

        let toilet = InteractibleItem(identifier: "toilet", texture: SKTexture(imageNamed: "TileSet-vasoSujo"), unlockedTexture: SKTexture(imageNamed: "TileSet-vasoLimpo"), position: (x: 3, y: 0), pickableItem: storageKey, unlockableItem: plunger)

        let interactibleStool = InteractibleItem(identifier: "stool", texture: SKTexture(imageNamed: "TileSet-banquinho"), unlockedTexture: SKTexture(), position: (x: 2, y: 2), pickableItem: pickableStool)
        interactibleStool.isRemovable = true

        // Bedroom furniture

        let bedroomToBalconyDoor = InteractibleItem(identifier: "bedroomToBalconyDoor", texture: SKTexture(imageNamed: "porta_fechada"), unlockedTexture: SKTexture(imageNamed: "porta_aberta"), position: (x:4,y:2), nextScene: OutsideScene.shared, unlockableItem: balconyKey)

        let bedsideTable = InteractibleItem(identifier: "bedsideTable", texture: SKTexture(imageNamed: "bedside_table"), pickedTexture: SKTexture(imageNamed: "bedside_table_unlocked"), position: (x: 4, y: 0), pickableItem: bathroomKey)

        let bed = InteractibleItem(identifier: "bed", texture: SKTexture(imageNamed: "bed"), unlockedTexture: SKTexture(imageNamed: "bed_unlocked"), pickedTexture: SKTexture(imageNamed: "bed_picked"), position: (x: 2, y: 4), pickableItem: crowbar, unlockableItem: lantern)
        let chest = InteractibleItem(identifier: "storage", texture: SKTexture(imageNamed: "storage"), unlockedTexture: SKTexture(imageNamed: "storage_unlocked"), pickedTexture: SKTexture(imageNamed: "storage_picked"), position: (x: 2, y: 0), pickableItem: ropes)

        let shelf = InteractibleItem(identifier: "shelf", texture: SKTexture(imageNamed: "shelf"), unlockedTexture: SKTexture(imageNamed: "shelf_unlocked"), pickedTexture: SKTexture(imageNamed: "shelf_picked"), position: (x: 0, y: 1), pickableItem: lantern, unlockableItem: pickableStool)

        let bedroomToTransitionRoomDoor = InteractibleItem(identifier: "bedroomToTransitionRoomDoor", texture: SKTexture(imageNamed: "porta_fechada"), unlockedTexture: SKTexture(imageNamed: "porta_aberta"), position: (x:0,y:4), nextScene: TransitionRoomScene.shared)

//        Transition room furniture

        let transitionRoomToBedroomDoor = InteractibleItem(identifier: "transitionRoomToBedroomDoor", texture: SKTexture(imageNamed: "porta_fechada"), unlockedTexture: SKTexture(imageNamed: "porta_aberta"), position: (x:2,y:6), nextScene: BedroomScene.shared)

        let transitionRoomTable = InteractibleItem(identifier: "transitionRoomTable", texture: SKTexture(imageNamed: "bedside_table"), unlockedTexture: SKTexture(imageNamed: "bedside_table_unlocked"), position: (x: 2, y: 4), pickableItem: balconyKey, unlockableItem: crowbar)

        let stairEnd = InteractibleItem(identifier: "stairEnd", texture: SKTexture(imageNamed: "stairEnd_collapsed"), unlockedTexture: nil, position: (x:0,y:1))

        let window = InteractibleItem(identifier: "window", texture: SKTexture(imageNamed: "TileJanela"), unlockedTexture: nil, position: (x:1,y:0))

        let transitionRoomToBathroomDoor = InteractibleItem(identifier: "transitionRoomToBathroomDoor", texture: SKTexture(imageNamed: "porta_fechada"), unlockedTexture: SKTexture(imageNamed: "porta_aberta"), position: (x:2,y:1), nextScene: BathroomScene.shared, unlockableItem: bathroomKey)

        // Balcony furniture

        let balconyToBedroomDoor = InteractibleItem(identifier: "balconyToBedroomDoor", texture: SKTexture(imageNamed: "porta_fechada"), unlockedTexture: SKTexture(imageNamed: "porta_aberta"), position: (x:0,y:), nextScene: OutsideScene.shared, unlockableItem: balconyKey)

        return [
            bathroomToTransitionRoomDoor,
            bathroomSink,
            toilet,
            interactibleStool,
            bedroomToBalconyDoor,
            bedsideTable,
            bed,
            chest,
            shelf,
            bedroomToTransitionRoomDoor,
            transitionRoomToBedroomDoor,
            transitionRoomTable,
            stairEnd,
            window,
            transitionRoomToBathroomDoor,
            balconyToBedroomDoor
        ]
    }
}
