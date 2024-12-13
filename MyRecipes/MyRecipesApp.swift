//
//  MyRecipesApp.swift
//  MyRecipes
//
//  Created by Shatha Almukhaild on 16/04/1446 AH.
//

import SwiftUI

@main

struct MyRecipesApp: App {
      var viewModel = RecipeViewModel()

    init() {
        //custom nav bar color
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named:"NavBarColor")/// Set your desired color

        // setting nav title colors
        //appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
       //appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        // Apply the appearance
        // standard appearance
        UINavigationBar.appearance().standardAppearance = appearance
        // scroll appearnce
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance // For compact navigation bar
    }
    var body: some Scene {
        WindowGroup {
            MainPage()
                .environmentObject(viewModel) // Pass the viewModel here

        }
    }
}
