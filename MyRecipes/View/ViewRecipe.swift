//
//  ViewRecipe.swift
//  MyRecipes
//
//  Created by Shatha Almukhaild on 25/04/1446 AH.
//

import SwiftUI

struct ViewRecipe: View {
    @ObservedObject var viewModel = RecipeViewModel()
    @State var navigateToView = false
    
    var body: some View {
        
        ZStack {
            NavigationStack {
                
                ScrollView {
                
                    VStack(spacing:20) {
                        Spacer()
                        Spacer()
                     
                        ZStack{
                      
                            if let image = viewModel.selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(maxWidth: UIScreen.screenWidth, maxHeight: 181, alignment: .leading)
                            } else {
                                // Placeholder image if the recipe image is nil
                                Image("SpoonNFork")
                                    .resizable()
                                    .frame(maxWidth: UIScreen.screenWidth, maxHeight: 181, alignment: .leading)
                            }
                            
                            // Gradient shadow
                            LinearGradient(gradient: Gradient(colors: [Color.clear,Color.black.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                                .frame(width: UIScreen.screenWidth, height: 181)
                          
                            
                            
                        }
                        
                       // Text("semi-hard cheese typically made from the milk of goats, sheep, or cows. It's known for its tangy taste and firm, chewy texture.")
                       Text("\(viewModel.currentDescription)").foregroundStyle(.secondary).padding()
                    }//.navigationTitle("recipe title")
                      .navigationTitle(viewModel.currentTitle)
                    
                    ZStack(alignment: .center){
                        VStack(spacing:15){
                            Text("Ingredients").font(.title).bold().padding(.trailing,200)
                            // call ingredients from recipe view model
                           
                        ForEach(viewModel.currentIngredients) { ingredient in
                           
                           // VStack{
                            ZStack{
                                HStack(){
    
                                    Rectangle()
                                        .frame(width: 358, height: 52)
                                        .foregroundStyle(Color("FillBackground"))
                                        .cornerRadius(7)
                                }
                              
                               
                                    Rectangle()
                                        .frame(width: 90, height: 29)
                                        .foregroundStyle(Color("ColorOrange"))
                                        .cornerRadius(7)
                                        .padding(.leading,230)
                                  
                                HStack() {
                                    //
                                    //padding()// Padding for the unit text
                                    Spacer(minLength: 70)
                                    Text("\(ingredient.quantity)")
                                        .font(.title3)
                                        .bold()
                                        .foregroundStyle(Color("ColorOrange"))
                                             Spacer(minLength: 10) // Pushes the remaining elements to the right

                                               Text("\(ingredient.name)")
                                                   .font(.title3)
                                                   .bold()
                                                   .foregroundStyle(Color("ColorOrange"))
                                                  // .padding(.trailing,150)
                                           
                                               Spacer()
                                               Spacer()
                                               Spacer()
                                               Spacer()
                                               Spacer()

                                             
                                           Text("\(ingredient.unit)")
                                          .foregroundStyle(Color(.white))
                                          .padding(.trailing, 60)
                                           }
    
                                }
                         }
                        }
    
  
                                           }// end of ZStack
                }.toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        Button(action: {
                            
                            // check if recipe details is empty or not before saving
                            guard
                                  viewModel.selectedImage != nil,
                                  !viewModel.currentTitle.isEmpty, // Check currentTitle instead of currentDescription
                                  !viewModel.currentDescription.isEmpty,
                                  !viewModel.currentIngredients.isEmpty
                              else {
                                  print("Recipe details can't be empty")
                                  return
                              }
                            
                            // Save new recipe
                          
                            let newRecipe = Recipe(
                                recipeTitle: viewModel.currentTitle,
                                recipeImage: viewModel.selectedImage,
                                Description: viewModel.currentDescription,
                                ingredients: viewModel.currentIngredients)
                            viewModel.recipes.append(newRecipe)
                         
                            // Debug output to check if recipes are saved or not
                            print("Saved Recipes: \(newRecipe)")
                            print("Current recipes: \(viewModel.recipes)")

                                         // set the navigation flag to navigate to edit recipe 
                                         navigateToView = true
                                     }) {
                                         Text("Edit")
                                                .font(.title3)
                                                .foregroundStyle(Color("ColorOrange"))
                                                    .frame(width: 44, height: 44)
                                     }
                                     .padding()

                               
                                     .navigationDestination(isPresented: $navigateToView) {
                                         AddNewRecipePage(viewModel: viewModel)
                                               }

                    }// end of ToolBarItem
                }// end of toolbar
                
            }
        }
    }
}

#Preview {
    ViewRecipe()
}
