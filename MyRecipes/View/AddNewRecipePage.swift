import SwiftUI
import PhotosUI
import Photos

struct AddNewRecipePage: View {
    @ObservedObject var viewModel = RecipeViewModel()

    // optional because there is no selection by default
    @State private var pickerItem: PhotosPickerItem?
    // State to manage pop up visibility
    @State private var showPopUp = false
    @State private var navigateToMain = false
   // the recipe to edit
    var recipeToEdit: Recipe?
    var body: some View {
        ZStack {
        NavigationStack {
            ScrollView {
                    Rectangle()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                        .foregroundColor(Color("ColorOrange"))
                        .frame(width: 481, height: 181)
                        .background(Color("FillBackground"))
                        .padding(.top,40)

                    VStack {
                        // If I didn't add matching the user can select any asset including videos and we don't want that
                        PhotosPicker(selection: $pickerItem, matching: .images) {
                            if viewModel.selectedImage == nil {
                                Image("UploadPhoto")
                                    .resizable()
                                    .frame(width: 85, height: 71)
                                    .padding(.top,40)
                                    
                            } else {
                                Image(uiImage: viewModel.selectedImage ?? UIImage())
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 481, height: 181)
                                    .clipped()
                                   // .padding(.bottom, 320)
                            }
                        }

                        if viewModel.selectedImage == nil {
                            Text("Upload Photo")
                                .font(.title2)
                                .bold()
                                .foregroundStyle(.primary)
                               // .padding(.bottom, 200)
                        }
                    }.padding(.top,-189) // End of VStack
                    
                    // To load the image from the library into the SwiftUI
                    .onChange(of: pickerItem) {
                        guard let pickerItem else { return }
                         Task {
                            do {
                              if let data = try await pickerItem.loadTransferable(type: Data.self) {
                   // Convert the data to a UIImage
                              if let image = UIImage(data: data) {
                              viewModel.selectedImage = image
                                    }
                                }
                            } catch {
                               print("Error loading image: \(error.localizedDescription)")
                                               }
                                           }
                                       }
                    VStack(alignment: .leading) {
                        Text("Title")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.primary)
                            .padding(.top, 20) // Adjust this value

                        TextField("Title", text: $viewModel.currentTitle)
                            .padding()
                            .frame(width: 350, height: 40)
                            .background(Color("FillBackground"))
                            .cornerRadius(7)
                            .onAppear {
                                // load the data into the view model when edit is clicked
                                if let recipe = recipeToEdit {
                                    viewModel.loadRecipe(recipe)
                                }
                            }
                        
                        Text("Description")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.primary)

                        ZStack(alignment: .topLeading) {
                            // To allow the user to enter multiple line text TextEditor is used
                            TextEditor(text: $viewModel.currentDescription)
                                .padding(.top, 2) // Adjust based on your design
                                .padding(.leading, 10)
                                .scrollContentBackground(.hidden)
                                .background(Color("FillBackground"))
                                .frame(width: 350, height: 100)
                                .cornerRadius(7)
                                .padding(.bottom, 20)

                            if viewModel.currentDescription.isEmpty {
                                Text("Description")
                                    .foregroundColor(Color(.lightGray))
                                    .padding(.top, 10)
                                    .padding(.leading, 15)
                            }
                        } // End of ZStack

                        // Main content with title, description, and add ingredients button
                        HStack(spacing: 150) {
                            Text("Add Ingredients").font(.title2).bold()
                            Button(action: {
                                showPopUp = true // Show the pop-up when clicked
                            }) {
                                Image(systemName: "plus")
                                    .font(.title)
                                    .foregroundStyle(Color("ColorOrange"))
                                    .frame(width: 44, height: 44)
                            }
                    //
                        } // End of HStack
                    }.navigationBarTitle("New Recipe") // End of VStack
                // show ingredients list if not empty
                       if !viewModel.currentIngredients.isEmpty{
                      
                                ZStack(alignment: .center){
                                    VStack(spacing:15){
                                    
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
                                                      .padding(.trailing, 90)
                                                       }
                                                             }
                                     }
                                    }
                
              
                                                       }// end of ZStack

                                    }
                    
                   
                }
         
            
            .toolbar {
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
                                id: recipeToEdit?.id ?? UUID(), // Reuse the existing recipe ID
                                recipeTitle: viewModel.currentTitle,
                                recipeImage: viewModel.selectedImage,
                                Description: viewModel.currentDescription,
                                ingredients: viewModel.currentIngredients)
                            // check if recipe is being edited or new added ?
                            if let recipeToEdit = recipeToEdit {
                                // update the recipe if its edited
                                viewModel.updateRecipe(oldRecipe: recipeToEdit,with: newRecipe)
                                print("Updated Recipes: \(viewModel.recipes)")

                            } else {
                                // to add a new recipe
                                viewModel.addRecipe(newRecipe: newRecipe)
                            }
                         
                            // Debug output to check if recipes are saved or not
                            print("Saved Recipes: \(newRecipe)")

                                         // set the navigation flag to navigate to main page after saving the recipe
                                         navigateToMain = true
                                     }) {
                                         Text("Save")
                                                .font(.title3)
                                                .foregroundStyle(Color("ColorOrange"))
                                                    .frame(width: 44, height: 44)
                                     }
                                     .padding()

                               
                                     .navigationDestination(isPresented: $navigateToMain) {
                                         MainPage()
                                               }

                    }
                }
                
            }.onAppear {
                print("Recipe to Edit: \(String(describing: recipeToEdit))")

                if recipeToEdit == nil {
                    // Reset properties for a new recipe
                    viewModel.resetCurrentRecipe()
                }
            }
            
            // Show the Pop-Up if the button is clicked
            if showPopUp {
                PopUpView(showPopUp: $showPopUp ,viewModel: viewModel)
            }
        }// End of ZStack// End of ZStack
        }
}

struct PopUpView: View {
    @Binding var showPopUp: Bool
    @ObservedObject var viewModel = RecipeViewModel()
    @State private var ingredientName = ""
    @State private var ingredientQuantity = 1
    @State private var ingredientUnit = ""
  
   
    enum MeasurementType{
        case spoon
        case cup
    }
    // State to track the selected measurement type
       @State private var selectedMeasurement: MeasurementType = .spoon
       

    
    var body: some View {
        ZStack (alignment:.center){
        
                if showPopUp {
                    Color("DimBackground").edgesIgnoringSafeArea(.all)
                }

            VStack(alignment: .leading ,spacing: 20) {
                    Text("Ingredient Name").font(.title2).bold()
                TextField("Ingredient Name",text: $ingredientName)
                        .padding()
                        .frame(width: 300,height: 39)
                        .background(Color("FillBackground"))
                        .cornerRadius(7)
                    Text("Measurement").font(.title2).bold()
                HStack{
                    Button(action:{
                        selectedMeasurement = .spoon
                        ingredientUnit = "🥄 Spoon"

                    }){
                        Text("🥄 Spoon ")
                        
                        
                    }
                    .frame(width: 104,height: 31)
                    .foregroundStyle(Color(.white))
                    .background(Color("ColorOrange"))
                    .cornerRadius(7)
                    Button(action:{
                        selectedMeasurement = .cup
                        ingredientUnit = "🥛 Cup"
                    }){
                        Text("🥛 Cup ")
                        
                        
                    }
                    .frame(width: 104,height: 31)
                    .foregroundStyle(Color(.white))
                    .background(Color("ColorOrange"))
                    .cornerRadius(7)
                }
                
                
                
                    Text("Serving").font(.title2).bold()
            
                ZStack(alignment: .center){
                    
                    Rectangle()
                        .frame(width: 241, height: 36)
                        .foregroundStyle(Color("FillBackground"))
                        .cornerRadius(7)
                    Rectangle()
                        .frame(width: 145, height: 36)
                        .foregroundStyle(Color("ColorOrange"))
                        .cornerRadius(7)
                        .padding(.leading,100)
                    if selectedMeasurement == .cup{
                      
                        Text("🥛 Cup ")
                            .foregroundStyle(.white)
                            .padding(.leading,90)
                    }
                    else{
                        Text("🥄 Spoon ")
                            .foregroundStyle(.white)
                            .padding(.leading,90)
                    }
                    Button(action:{
                        ingredientQuantity = ingredientQuantity + 1
                    }){
                  
                        Text("+")
                            .font(.title)
                                  .foregroundStyle(Color("ColorOrange"))
                                  .frame(width: 30, height: 25)
                                  .overlay(
                                      RoundedRectangle(cornerRadius: 7)
                                      .stroke(Color("ColorOrange"), lineWidth: 1)
                                  )

                    }.padding(.trailing,90)
                       
                    Text("\(ingredientQuantity)").padding(.trailing,145)
                    
                    Button(action:{
                        if ingredientQuantity == 1{}
                        else{
                            ingredientQuantity = ingredientQuantity - 1
                        }
                    }){
                        Text("-")
                            .font(.title)
                            .foregroundStyle(Color("ColorOrange"))
                            .frame(width: 30, height: 25)
                            .overlay(
                                RoundedRectangle(cornerRadius: 7)
                                .stroke(Color("ColorOrange"), lineWidth: 1)
                                  )

                        
                    }.padding(.trailing,200)
                    //.background(C)
                }
               
                
                VStack(alignment: .center){
                    HStack (spacing:20){
                        Button(action: {
                            showPopUp = false // Hide on cancel
                        }) {
                            Text("Cancel")
                                .font(.title2)
                                .frame(width: 134,height: 36)
                                .foregroundStyle(Color("ColorOrange"))
                                .background(Color("FillBackground"))
                               
                                .cornerRadius(7)
                        }
                        Button(action: {
                            
                            // ingredients can't be saved if its empty
                            guard !ingredientName.isEmpty else {
                                  print("Ingredient name cannot be empty.")
                                  return
                              }
                            // Save the ingredient
                            let newIngredient = Ingredient(
                                   name: ingredientName,
                                   unit: "\(selectedMeasurement == .cup ? "🥛 Cup" : "🥄 Spoon")",
                                   quantity: ingredientQuantity
                               )
                               viewModel.currentIngredients.append(newIngredient)

                               // Debug output
                               print("Saved Ingredient: \(newIngredient)")
                               print("Current Ingredients: \(viewModel.currentIngredients)")

                               
                            showPopUp = false // Hide on save
                        }) {
                            Text("Save")
                                .font(.title2)
                                .frame(width: 134,height: 36)
                                .foregroundStyle(Color(.white))
                                .background(Color("ColorOrange"))
                                .cornerRadius(7)
                        }
                    }
                }
                }
            
                .frame(width: 306,height: 382)
                .padding()
             //NavBarColor make pop background adaptable to light and dark mode
                .background(Color("NavBarColor"))
                .cornerRadius(10)
                .padding(40)
                
            }
        }
    }


struct AddNewRecipePage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddNewRecipePage()
                .preferredColorScheme(.light)
            AddNewRecipePage()
                .preferredColorScheme(.dark)
        }
    }
}
