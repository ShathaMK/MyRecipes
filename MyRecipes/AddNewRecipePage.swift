import SwiftUI
import PhotosUI
import Photos

struct AddNewRecipePage: View {
    @ObservedObject var viewModel = RecipeViewModel()
    // optional because there is no selection by default
    @State private var pickerItem: PhotosPickerItem?
   // @State private var selectedImage: UIImage?

 
    var body: some View {
        NavigationStack {
            ScrollView {
                
                
                ZStack {
                    
                    Rectangle()
                        .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                        .foregroundColor(Color("ColorOrange"))
                        .frame(width: 481, height: 181)

                        .background(Color("FillBackground"))
                        .padding(.bottom, 320)
                
                    
                    VStack {
                        // If i didnt add matching the user can select any asset including videos and we dont want that
                        PhotosPicker(selection: $pickerItem, matching: .images){
                            
                            if (viewModel.selectedImage==nil){
                                Image("UploadPhoto")
                                    .resizable()
                                    .frame(width: 85, height: 71)
                            }
                            else{
                                Image(uiImage: viewModel.selectedImage ?? UIImage())
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 481, height: 181)
                                    .clipped()
                                    .padding(.bottom, 320)
                            }
                         
                       
                          

                            
                        }
                        
                        if (viewModel.selectedImage==nil){
                            
                            Text("Upload Photo")
                                .font(.title2)
                                .bold()
                                .foregroundStyle(.primary)
                                .padding(.bottom, 320)
                            
                        }
                        
                        
                    }// End of VStack
                    
                    // to load the image from the library into the swiftui
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
                                // .padding(.trailing, 300)
                                    .padding(.top,260)// Adjust this value
                                
                                TextField("Title", text: $viewModel.currentTitle)
                                    .padding()
                                    .frame(width: 350, height: 40)
                                    .background(Color("FillBackground"))
                                    .cornerRadius(7)
                                
                                
                                
                                
                                Text("Description")
                                    .font(.title2)
                                    .bold()
                                //.padding(.trailing,230)
                                    .foregroundStyle(.primary)
                                
                                //
                                
                                ZStack(alignment: .topLeading) {
                                    // To allow the user to enter multiple line text TextEditor is used
                                    TextEditor(text: $viewModel.currentDescription)
                                    // in order for the background color to change this has to be hidden
                                        .padding(.top, 2) // Adjust based on your design
                                        .padding(.leading, 10)
                                        .scrollContentBackground(.hidden)
                                        .background(Color("FillBackground"))
                                    
                                        .frame(width:350,height: 100)
                                        .cornerRadius(7)
                                        .padding(.bottom, 20)
                                    
                                    if viewModel.currentDescription.isEmpty {
                                        Text("Description")
                                            .foregroundColor(Color(.lightGray))
                                            .padding(.top, 10)
                                            .padding(.leading, 15)
                                        
                                    }
                                    
                                    
                                }// End of ZStack
                                
                                HStack(spacing: 150){
                                    
                                    Text("Add Ingredients").font(.title2).bold()
                                    
                                    
                                    NavigationLink(destination: AddNewRecipePage()) {
                                        Image(systemName: "plus")
                                            .font(.title).foregroundStyle(Color("ColorOrange")).frame(width: 44,height: 44) 
                                    }
                                    
                                }// End of HStack
                            }// End of VStack
                        }// End of ZStack
                        .navigationBarTitle("New Recipe")
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
                } // End of Navigation Stack
            }
        }


struct AddNewRecipePage_Previews: PreviewProvider{
    static var previews: some View{
        AddNewRecipePage()
        /* To make sure your colors are adaptable in both mods
        Group preview was used */
        Group{
            AddNewRecipePage()
                .preferredColorScheme(.light)
            AddNewRecipePage()
                .preferredColorScheme(.dark)
            
        }
    }
    
}

   //
