import SwiftUI
import FirebaseFirestore
import FirebaseStorage

struct AddMilestone: View {
    @EnvironmentObject var account: Account
    @Environment(\.presentationMode) var presentationMode
    @Namespace var namespace
    @State var index: Int
    @State private var sourceType: UIImagePickerController.SourceType? = nil
    @State public var selectedImage: UIImage? = nil
    @State private var isImagePickerDisplay = false
    @State private var significant = true
    @State var chosen = false
    @State private var caption = ""
    @State private var isCameraDisplay = false
    @State private var isPhotoLibraryDisplay = false
    @State private var dummy = false
    @State private var showingErrorAlert = false
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
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                            .overlay(Circle()
                                .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                .foregroundColor(.white)
                            )
                            .frame(width: 300, height: 200)

                    } else {
                        Image("gray_camera")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .cornerRadius(10.0)
                        //.clipShape(Circle())
                            .overlay(Circle()
                                .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
                                .foregroundColor(.white)
                            )
                            .frame(width: 300, height: 200)

                    }
                    if (significant) {
                        VStack(spacing: 30) {
                            TextField("Add caption here", text: $caption)
                                .padding()
                                .frame(maxWidth: .infinity, minHeight: 50)
                                .matchedGeometryEffect(id: "caption", in: namespace)

                            Path { path in
                                path.move(to: CGPoint(x: 0, y: 0))
                                path.addLine(to: CGPoint(x: geometry.size.width, y:0))
                            }
                            .stroke(Color.black, lineWidth: 0.2)
                            .matchedGeometryEffect(id: "divider", in: namespace)

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
                                .background(.blue)
                                .cornerRadius(35)
                                
                        }
                        .matchedGeometryEffect(id: "photo", in: namespace)
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
                                .background(.gray)
                                .cornerRadius(35)
                                

                        }
                        .matchedGeometryEffect(id: "choose_photo", in: namespace)
                        HStack {
                            Spacer()
                            Text("Significant milestone?")
                                .font(Font.custom(
                                    "Lexend-SemiBold",
                                    fixedSize: 18))
                                .frame(width: 200)
                                .matchedGeometryEffect(id: "sig", in: namespace)
                            
                            Button(action: {
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                    significant.toggle()
                                }
                            }) {
                                Text("No")
                                    .foregroundColor(.black)
                                Text("|")
                                    .foregroundColor(.black)
                                Text("Yes")
                                    .font(Font.custom(
                                        "Lexend-SemiBold",
                                        fixedSize: 18))
                                    .foregroundColor(.red)
                                    .bold()
                            }
                            .padding(5)
                            .frame(width: 100)
                            .background(.blue)
                            .cornerRadius(15)
                            .matchedGeometryEffect(id: "button", in: namespace)
                            Spacer()
                        }
                        .padding(.top)
                        .frame(maxWidth: .infinity)
                        Spacer()
                        Button(action: {
                                if (selectedImage != nil) {
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
                            
                        } else {
                            showingErrorAlert = true
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
                    } else {
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
                                .background(.blue)
                                .cornerRadius(35)
                                
                        }
                        .padding(.top)
                        .matchedGeometryEffect(id: "photo", in: namespace)
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
                                .background(.gray)
                                .cornerRadius(35)
                        }
                        .matchedGeometryEffect(id: "choose_photo", in: namespace)
                        HStack {
                            Spacer()
                            Text("Significant milestone?")
                                .font(Font.custom(
                                    "Lexend-SemiBold",
                                    fixedSize: 18))
                                .frame(width: 200)
                                .matchedGeometryEffect(id: "sig", in: namespace)
                            
                            Button(action: {
                                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                    significant.toggle()
                                }
                            }) {
                                Text("No")
                                    .font(Font.custom(
                                        "Lexend-SemiBold",
                                        fixedSize: 18))
                                    .foregroundColor(.red)
                                    .bold()
                                Text("|")
                                    .foregroundColor(.black)
                                Text("Yes")
                                    .foregroundColor(.black)
                            }
                            .padding(8)
                            .frame(width: 100)
                            .background(.blue)
                            .cornerRadius(15)
                            .matchedGeometryEffect(id: "button", in: namespace)
                            Spacer()
                        }
                        .padding(.top)
                        .frame(maxWidth: .infinity)
                        Spacer()
                        Button(action: {
                            if (selectedImage) != nil {
                                // Convert the image to data
                                guard let imageData = selectedImage?.jpegData(compressionQuality: 0.5) else { return }
                                
                                // Generate a unique name for the image file
                                let imageName = UUID().uuidString
                                let storageRef = Storage.storage().reference().child("images/\(imageName).jpg")
                                storageRef.putData(imageData, metadata: nil) { metadata, error in
                                    guard error == nil else {
                                        print("Failed to upload image: \(error?.localizedDescription ?? "No error description.")")
                                        return
                                    }
                                    storageRef.downloadURL { url, error in
                                        guard let url = url, error == nil else {
                                            print("Failed to get download URL: \(error?.localizedDescription ?? "No error description.")")
                                            return
                                        }
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
                                                showingErrorAlert = true
                                            } else {
                                                print("Milestone successfully added!")
                                            }
                                        }
                                        
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                    
                                }
                            } else {
                                showingErrorAlert = true
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

                    }

                    
                    
                    
                    
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
        .alert(isPresented: $showingErrorAlert) {
            Alert(title: Text("Error"), message: Text("Please select or take a photo"), dismissButton: .default(Text("OK")))
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
