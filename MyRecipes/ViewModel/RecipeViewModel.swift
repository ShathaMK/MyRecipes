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
        @Published var selectedImage: UIImage? //to store the selected image
        @Published var currentIngredients: [Ingredient] = []// to store multiple ingredients as each recipe can require more than 1 ingredient
    
    func addRecipe(){
        let newRecipe = Recipe(recipeTitle: currentTitle, recipeImage: selectedImage, Description: currentDescription, ingredients: currentIngredients)
        recipes.append(newRecipe)
       // resetCurrentRecipe()
        
    }
    // a function to reset user input field after the user saves the recipe
    func resetCurrentRecipe()
    {
        selectedImage = nil
        currentTitle = ""
        currentDescription=""
        currentIngredients = []
        
    }
    func deleteRecipe(_ recipe: Recipe) {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes.remove(at: index)
        }
    }
    func loadRecipe(_ recipe: Recipe) {
        currentTitle = recipe.recipeTitle
        currentDescription = recipe.Description
        selectedImage = recipe.recipeImage
        currentIngredients = recipe.ingredients
    }
//    // Add a method to load a recipe for editing
//    func loadRecipe(_ recipe: Recipe) {
//        self.selectedImage = recipe.recipeImage
//        self.currentTitle = recipe.recipeTitle
//        self.currentDescription = recipe.Description
//        self.currentIngredients = recipe.ingredients
//    }
    func addIngredient(name: String, quantity: Int, unit: String) {
        let newIngredient = Ingredient(name: name, unit: unit, quantity: quantity)
            currentIngredients.append(newIngredient)
        }
        
        func removeIngredient(at offsets: IndexSet) {
            currentIngredients.remove(atOffsets: offsets)
        }

 
    
}
