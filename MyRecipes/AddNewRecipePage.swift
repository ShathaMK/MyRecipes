import SwiftUI
import PhotosUI
import Photos

struct AddNewRecipePage: View {
    @ObservedObject var viewModel = RecipeViewModel()
    // optional because there is no selection by default
    @State private var pickerItem: PhotosPickerItem?
    // State to manage pop up visibility
    @State private var showPopUp = false
    
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
//
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
                        } // End of HStack

                        
                    }.navigationBarTitle("New Recipe") // End of VStack
                   
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: MainPage()) {
                        Text("Save")
                            .font(.title3)
                            .foregroundStyle(Color("ColorOrange"))
                            .frame(width: 44, height: 44)
                    }
                }
            }
            // Show the Pop-Up if the button is clicked
            if showPopUp {
                PopUpView(showPopUp: $showPopUp)
            }
        }// End of ZStack// End of ZStack
        }
}

struct PopUpView: View {
    @Binding var showPopUp: Bool
    @State var ingname = ""
    @State private var stepperOn = 0
   
    enum MeasurementType{
        case spoon
        case cup
    }
    // State to track the selected measurement type
       @State private var selectedMeasurement: MeasurementType = .spoon
       
    
    let step = 1
    let range = 1...20
    
    var body: some View {
        ZStack (alignment:.center){
        
                if showPopUp {
                    Color("DimBackground").edgesIgnoringSafeArea(.all)
                }

            VStack(alignment: .leading ,spacing: 20) {
                    Text("Ingredient Name").font(.title2).bold()
                    TextField("Ingredient Name",text: $ingname)
                        .padding()
                        .frame(width: 300,height: 39)
                        .background(Color("FillBackground"))
                        .cornerRadius(7)
                    Text("Measurement").font(.title2).bold()
                HStack{
                    Button(action:{
                        selectedMeasurement = .spoon

                    }){
                        Text("🥄 Spoon ")
                        
                        
                    }
                    .frame(width: 104,height: 31)
                    .foregroundStyle(Color(.white))
                    .background(Color("ColorOrange"))
                    .cornerRadius(7)
                    Button(action:{
                        selectedMeasurement = .cup
                    }){
                        Text("🥛 Cup ")
                        
                        
                    }
                    .frame(width: 104,height: 31)
                    .foregroundStyle(Color(.white))
                    .background(Color("ColorOrange"))
                    .cornerRadius(7)
                }
                
                
                
                    Text("Serving").font(.title2).bold()
                    Stepper(value: $stepperOn,
                            in:range,step: step){
                        if selectedMeasurement == .cup{
                            Text("🥛 Cup ")
                        } else{
                            Text("🥄 Spoon ")
                        }
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
                            // Add logic to save the ingredient
                            // Add your saving logic here
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
