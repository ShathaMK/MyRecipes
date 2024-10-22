//
//  Recipe.swift
//  MyRecipes
//
//  Created by Shatha Almukhaild on 17/04/1446 AH.
//

import SwiftUI
struct Recipe: Identifiable {
    var id = UUID()
    var recipeTitle: String
    var recipeImage: String
    var Description: String
}
