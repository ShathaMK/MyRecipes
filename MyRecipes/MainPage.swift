//
//  MainPage.swift
//  MyRecipes
//
//  Created by Shatha Almukhaild on 16/04/1446 AH.
//

import SwiftUI

struct MainPage: View {
    // used to check if there is a recipe and change the view based on that
   var  recipeExist = false
    var body: some View {

        NavigationStack{
            ScrollView{

                VStack(alignment: .center){
                
                    
                    if(recipeExist){
                        
                    }
                    else{
                        Image("SpoonNFork").resizable().frame(width: 325,height: 327).padding(.top,86)
                        
                            /* to make the colors of the text adaptable to light and dark mode
                            .primary is black in light mode and white in dark mode
                            .secondary is gray in both modes */
                        
                        Text("There's no recipe yet").font(.system(.largeTitle)).bold().foregroundStyle(.primary).padding(.top,24)
                        Text("Please add your recipes").font(.system(.title3)).foregroundStyle(.secondary).padding(.top,-2)
                    }
                }.navigationBarTitle("Food Recipes")//End of VStack
                 .navigationBarBackButtonHidden(true) // Hide the back button when new recipe added 

                }//End of ScrollView
                .toolbar {
                                // Adding SF Symbol as a button in the top bar
                   
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    NavigationLink(destination: AddNewRecipePage()) {
                                        Image(systemName: "plus")
                                            .font(.title).foregroundStyle(Color("ColorOrange")).frame(width: 44,height: 44) // Adjust size as needed
                                    }
                                }
                            }
            }

            
        
        
    }// End of body
}// End of struct

struct MainPage_Previews: PreviewProvider{
    static var previews: some View{
        MainPage()
        /* To make sure your colors are adaptable in both mods
        Group preview was used */
//        Group{
//            MainPage()
//                .preferredColorScheme(.light)
//            MainPage()
//                .preferredColorScheme(.dark)
//            
//        }
    }
    
}
#Preview {
    MainPage()
}
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
