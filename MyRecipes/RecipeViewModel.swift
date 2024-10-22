//
//  RecipeViewModel.swift
//  MyRecipes
//
//  Created by Shatha Almukhaild on 17/04/1446 AH.
//

import SwiftUI
class RecipeViewModel: ObservableObject{
    @Published var recipes: [Recipe] = [] // Array to hold multiple recipes
        @Published var currentTitle: String = ""
        @Published var currentDescription: String = ""
//    init(){
//        
//        addRecipe()
//    }
//    func shuffleOrder(){
//        recipes.shuffle()
//    }
//    
//    func reverseOrder(){
//        recipes.reverse()
//    }
//    
//    func removeLastRecipe(){
//        recipes.removeLast()
//    }
//    
//    func removeFirstRecipe(){
//        recipes.removeFirst()
//    }
//    func addRecipe(){
//        recipes.append()
//    }
    let recipeData = [
        Recipe(recipeTitle: "Tiramisu", recipeImage: "SpoonNFork", Description: "you need eggs"),
        Recipe(recipeTitle: "pasta", recipeImage: "SpoonNFork", Description: "you need eggs"),
        Recipe(recipeTitle: "Salad", recipeImage: "SpoonNFork", Description: "you need eggs")
    ]
    
}
