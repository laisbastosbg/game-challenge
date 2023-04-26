//
//  InventoryView.swift
//  Feri
//
//  Created by Otávio Albuquerque on 26/04/23.
//

import SwiftUI

struct InventoryView: View {
    @ObservedObject var inventoryItems: Inventory
    var body: some View {
        
        Grid{
            GridRow{
                ForEach(0..<4){ index in
                    ZStack{
                        Image("UI-Inventario-item")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding()
                        if inventoryItems.items.indices.contains(index){
                            Image(inventoryItems.items[index].textureName)
                        }
                    }

                    
                }
            }
            GridRow{
                ForEach(4..<8){ index in
                    ZStack{
                        Image("UI-Inventario-item")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding()
                        if inventoryItems.items.indices.contains(index){
                            Image(inventoryItems.items[index].textureName)
                        }
                    }

                   
                }
            }
        }
        
    }
}

struct InventoryView_Previews: PreviewProvider {
    static var previews: some View {
        InventoryView(inventoryItems: Inventory.shared)
    }
}
