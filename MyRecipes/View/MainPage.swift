//
//  MainPage.swift
//  MyRecipes
//
//  Created by Shatha Almukhaild on 16/04/1446 AH.
//

import SwiftUI
import SwiftData
//
struct MainPage: View {
    // used to check if there is a recipe and change the view based on that
    @ObservedObject var viewModel = RecipeViewModel()
    @State var navigateToView = false

    var body: some View {

        NavigationStack{
            ScrollView{
                //list recipes if its not empty
                if(!viewModel.recipes.isEmpty){
                    ForEach(viewModel.recipes) { recipe in
                    Spacer()
                    VStack(alignment: .center){
                        
                        ZStack(alignment: .leading){
                            // Safely unwrap the image
                            if let image = recipe.recipeImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .frame(maxWidth: UIScreen.screenWidth, maxHeight: 272, alignment: .leading)
                                    } else {
                                    // Placeholder image if the recipe image is nil
                                       Image("SpoonNFork")
                                            .resizable()
                                            .frame(maxWidth: UIScreen.screenWidth, maxHeight: 272, alignment: .leading)
                                         }
                            
                               // Gradient shadow
                            LinearGradient(gradient: Gradient(colors: [Color.clear,Color.black.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                                .frame(width: UIScreen.screenWidth, height: 272)
                                              

                                
                            Text("\(recipe.recipeTitle)").font(.title).bold().foregroundStyle(.white)
                                .padding(.top,75)
                                .padding(.leading,20)
                                .padding(.bottom)
                            
                            VStack (alignment: .leading){
                                Text("\(recipe.Description)").font(.footnote).lineLimit(2)
                                    
                                    .frame(maxWidth: 360, alignment: .leading)
                                    .foregroundStyle(.white)
                                    .padding(.top,200).padding(.leading,25)
                                //Spacer()
                                Button(action:{
                                    navigateToView = true
                                }){
                                    Text("See All").font(.footnote).foregroundStyle(Color("ColorOrange")).bold()
                                        .padding(.leading,25)
                                        .padding(.bottom)
                                }
                                .navigationDestination(isPresented: $navigateToView) {
                                    ViewRecipe(viewModel: viewModel)
                                          }//.padding(.top,240)
                                   // .padding(.leading,130)
                                
                                Spacer()
                            }
                            
                            
                        }
                        
                     
                        //                        
                                            }
                       
                    }.padding(.horizontal)
                    .padding(.top,25)// Optional: adds padding to the VStack
                    .navigationBarTitle("Food Recipes")//End of VStack
                    .navigationBarBackButtonHidden(true)
                    //
                } // Hide the back button when new recipe added
                else{
                    VStack{
                        Image("SpoonNFork")
                            .resizable()
                            .frame(width: 325,height: 327)
                            .padding(.top,86)
                        
                        /* to make the colors of the text adaptable to light and dark mode
                         .primary is black in light mode and white in dark mode
                         .secondary is gray in both modes */
                        
                        Text("There's no recipe yet")
                            .font(.system(.largeTitle))
                            .bold()
                            .foregroundStyle(.primary)
                            .padding(.top,24)
                        Text("Please add your recipes")
                            .font(.system(.title3))
                            .foregroundStyle(.secondary)
                            .padding(.top,-2)
                    }.navigationBarTitle("Food Recipes")//End of VStack
                     .navigationBarBackButtonHidden(true)
                }
                }//End of ScrollView
                .toolbar {
                                // Adding SF Symbol as a button in the top bar
                   
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    NavigationLink(destination: AddNewRecipePage(viewModel: viewModel)) {
                                        Image(systemName: "plus")
                                            .font(.title).foregroundStyle(Color("ColorOrange")).frame(width: 44,height: 44) // Adjust size as needed
                                    }
                                }
                            }
            }// end of NavigationStack

            
        
        
    }// End of body
}// End of struct

struct MainPage_Previews: PreviewProvider{
    static var previews: some View{
        /* To make sure your colors are adaptable in both mods
        Group preview was used */
        Group{
            MainPage()
                .preferredColorScheme(.light)
            MainPage()
                .preferredColorScheme(.dark)
            
        }
    }
    
}

// to pick color in hex format Color(hex:0x000000) used like this
extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 8) & 0xff) / 255,
            blue: Double((hex >> 0) & 0xff) / 255,
            opacity: alpha
        )
    }
}
// to make the interfaces responsive to each device we use this extension
// to use UIScreen.screenWidth for example
extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}
