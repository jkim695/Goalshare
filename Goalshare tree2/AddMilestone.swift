import SwiftUI
import FirebaseFirestore
import FirebaseStorage

struct AddMilestone: View {
    @EnvironmentObject var account: Account
    @Environment(\.presentationMode) var presentationMode
    @State var index: Int
    @State private var sourceType: UIImagePickerController.SourceType? = nil
    @State public var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    @State private var significant = true
    @State var chosen = false
    @State private var caption = ""
    @State private var isCameraDisplay = false
    @State private var isPhotoLibraryDisplay = false
    var body: some View {
        GeometryReader { geometry in
            
            ZStack {
                Color.yellow.edgesIgnoringSafeArea(.all)
                VStack {
                    ZStack {
                        HStack {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Text("Cancel")
                                    .padding(20)
                            }
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Text("Add miletone")
                                .font(.headline)
                                .scaleEffect(1.5)
                            Spacer()
                        }
                    }
                    if selectedImage != nil {
                        Button(action: {
                            // Convert the image to data
                            guard let imageData = selectedImage?.jpegData(compressionQuality: 0.5) else { return }
                            
                            // Generate a unique name for the image file
                            let imageName = UUID().uuidString
                            
                            // Create a reference to the image file in Firebase Storage
                            let storageRef = Storage.storage().reference().child("images/\(imageName).jpg")
                            
                            // Upload the image data to the new reference
                            storageRef.putData(imageData, metadata: nil) { metadata, error in
                                guard error == nil else {
                                    print("Failed to upload image: \(error?.localizedDescription ?? "No error description.")")
                                    return
                                }
                                
                                // Get the download URL for the image
                                storageRef.downloadURL { url, error in
                                    guard let url = url, error == nil else {
                                        print("Failed to get download URL: \(error?.localizedDescription ?? "No error description.")")
                                        return
                                    }
                                    
                                    // Convert URL to String
                                    
                                    // Create a new milestone with the image URL
                                    let newMilestone = Milestone(name: "", sig: significant, image: Image(uiImage: selectedImage!), imageUrlString: url.absoluteString, caption: self.caption)
                                    
                                    // Add the new milestone to the goal's milestones array
                                    account.goals[index].milestones.append(newMilestone)
                                    
                                    // Add the new milestone to Firestore
                                    let db = Firestore.firestore()
                                    let newMilestoneRef = db.collection("accounts").document(account.id).collection("goals").document(account.goals[index].id!).collection("milestones").document(newMilestone.id.uuidString)
                                    newMilestoneRef.setData([
                                        "name": newMilestone.name,
                                        "sig": newMilestone.sig,
                                        "image": newMilestone.imageUrlString, // Assuming imageUrl is a String property
                                        "caption": newMilestone.caption,
                                        "id": newMilestoneRef.documentID,
                                        "date": newMilestone.date
                                        
                                    ]) { error in
                                        if let error = error {
                                            print("Error adding milestone: \(error)")
                                        } else {
                                            print("Milestone successfully added!")
                                        }
                                    }
                                    
                                    presentationMode.wrappedValue.dismiss()
                                }
                                
                            }
                        }) {
                            Text("ADD")
                                .font(Font.custom(
                                    "Lexend-SemiBold",
                                    fixedSize: 20))
                                .foregroundColor(.black)
                                .padding(.horizontal, 85.0)
                                .padding(.vertical, 7.0)
                                .background(.green)
                                .cornerRadius(35)
                        }
                        
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        //.clipShape(Circle())
                            .overlay(Circle()
                                .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                .foregroundColor(.white)
                            )
                            .frame(width: 300, height: 200)
                            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)

                    } else {
                        Image("fedW")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(10.0)
                        //.clipShape(Circle())
                            .overlay(Circle()
                                .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                .foregroundColor(.white)
                            )
                            .frame(width: geometry.size.width / 1.1, height: 200)

                    }
                    VStack(spacing: 30) {
                        TextField("Add caption here", text: $caption)
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 50)
                        Path { path in
                            path.move(to: CGPoint(x: 0, y: 0))
                            path.addLine(to: CGPoint(x: geometry.size.width, y:0))
                        }
                        .stroke(Color.black, lineWidth: 0.2)
                    }
                    .frame(height: geometry.size.height / 7)
                    Button {
                        self.sourceType = .camera
                        self.isCameraDisplay.toggle()
                    } label: {
                        Text("  Take Photo  ")
                            .font(Font.custom(
                                "Lexend-SemiBold",
                                fixedSize: 20))
                            .foregroundColor(.black)
                            .padding(.horizontal, 85.0)
                            .padding(.vertical, 7.0)
                            .background(.green)
                            .cornerRadius(35)
                    }
                    Button {
                        self.sourceType = .photoLibrary
                        self.isPhotoLibraryDisplay.toggle()
                    } label: {
                        Text("Choose Photo")
                            .font(Font.custom(
                                "Lexend-SemiBold",
                                fixedSize: 20))
                            .foregroundColor(.black)
                            .padding(.horizontal, 85.0)
                            .padding(.vertical, 7.0)
                            .background(.red)
                            .cornerRadius(35)
                    }
                    HStack {
                        Spacer()
                        Text("Milestone?")
                        Toggle(isOn: $significant) {
                            EmptyView()
                        }
                        .frame(maxWidth: .infinity, maxHeight: 80, alignment: .center)
                        .shadow(radius: 2)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(50) // Add padding around the VStack
                    Spacer()
                }
                .fullScreenCover(isPresented: self.$isCameraDisplay, content: {
                    Camera(selectedImage: self.$selectedImage, sourceType: .camera)
                        .edgesIgnoringSafeArea(.all)
                })
                .fullScreenCover(isPresented: self.$isPhotoLibraryDisplay, content: {
                    Camera(selectedImage: self.$selectedImage, sourceType: .photoLibrary)
                        .edgesIgnoringSafeArea(.all)
                })
            }
        }
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        let account = Account(id: "")
        account.goals.append(Goal(id: "", name: "", date: Date(), pin: false))
        return AddMilestone(index: 0)
            .environmentObject(Account(id: ""))
    }
}
