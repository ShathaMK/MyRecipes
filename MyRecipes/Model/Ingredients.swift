//
//  Ingredients.swift
//  MyRecipes
//
//  Created by Shatha Almukhaild on 24/04/1446 AH.
//
import SwiftData
import SwiftUI
struct Ingredient:Identifiable{
    var id = UUID()
    var name: String
    var unit: String // "cup", "spoon"
    var quantity: Int
    init(id: UUID = UUID(), name: String, unit: String, quantity: Int) {
        self.id = id
        self.name = name
        self.unit = unit
        self.quantity = quantity
    }
}
