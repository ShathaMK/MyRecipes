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
    @Published var selectedRecipe: Recipe? // Optional to track selected recipe logic



    
    func addRecipe(newRecipe:Recipe){
        let newRecipe = Recipe(
            recipeTitle: currentTitle,
            recipeImage: selectedImage,
            Description: currentDescription,
            ingredients: currentIngredients)
        recipes.append(newRecipe)
        objectWillChange.send() // Force SwiftUI to re-render

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
    // method to delete a recipe
    func deleteRecipe(_ recipe: Recipe) {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes.remove(at: index)
        }
    }
    //  method to load a recipe for editing
    func loadRecipe(_ recipe: Recipe) {
        guard let index = recipes.firstIndex(where: { $0.id == recipe.id }) else {
               print("No matching recipe found with ID: \(recipe.id)")
               return
           }
           print("Loaded recipe for editing: \(recipes[index])")
        currentTitle = recipe.recipeTitle
        currentDescription = recipe.Description
        selectedImage = recipe.recipeImage
        currentIngredients = recipe.ingredients
    }
    // method to edit recipe
    func updateRecipe(oldRecipe: Recipe, with newRecipe:Recipe){
        // find the old recipe id to replace with the edited recipe $0 refer to each recipe in the array during the search
        if let index = recipes.firstIndex(where: { $0.id==oldRecipe.id }){
            recipes[index] = newRecipe
            objectWillChange.send() // Force SwiftUI to re-render

            print("Updated Recipes: \(recipes)")

        }else {
            // Optionally handle the case where the recipe is not found, though ideally, this should not happen
            print("Error: Recipe not found.")
        }
    }
    //method to add a new ingredient
    func addIngredient(name: String, quantity: Int, unit: String) {
        let newIngredient = Ingredient(name: name, unit: unit, quantity: quantity)
            currentIngredients.append(newIngredient)
        }
        // method to remove an ingredient
    func removeIngredient(at offsets: IndexSet) {
            currentIngredients.remove(atOffsets: offsets)
        }

 
    
}
