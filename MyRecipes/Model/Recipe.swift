//
//  Recipe.swift
//  MyRecipes
//
//  Created by Shatha Almukhaild on 17/04/1446 AH.

import SwiftData
import SwiftUI
struct Recipe: Identifiable {
    var id = UUID()
    var recipeTitle: String
    var recipeImage: UIImage?
    var Description: String
    var ingredients: [Ingredient]
    init(id: UUID = UUID(), recipeTitle: String, recipeImage: UIImage? = nil, Description: String, ingredients: [Ingredient]) {
        self.id = id
        self.recipeTitle = recipeTitle
        self.recipeImage = recipeImage
        self.Description = Description
        self.ingredients = ingredients
    }

}
