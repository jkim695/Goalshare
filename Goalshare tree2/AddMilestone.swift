import SwiftUI

struct AddMilestone: View {
    @EnvironmentObject var goal: Goal
    @Environment(\.presentationMode) var presentationMode
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State public var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    @State private var significant = true
    @State var chosen = false
    @State private var complete = false
    @State private var isCameraPickerDisplayed = false
    @State private var isPhotoLibraryPickerDisplayed = false
    @State private var caption = ""
    var body: some View {
        ZStack {
            Color.yellow.edgesIgnoringSafeArea(.all)
            VStack {
                if selectedImage != nil {
                    NavigationLink(destination: Tree()
                        .environmentObject(goal), isActive: $complete) {
                        EmptyView()
                    }
                    Button( action: {
                        goal.milestones.append(Milestone(name: "", sig: significant, image: Image(uiImage: selectedImage!), date: "", caption: self.caption))
                        complete = true
                    }) {
                        Text("ADD")
                            .font(.headline)
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
                } else {
                    Image("fedW")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        //.clipShape(Circle())
                        .overlay(Circle()
                            .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [5]))
                            .foregroundColor(.white)
                        )
                        .frame(width: 300, height: 200)
                }
                TextField("  Add caption here", text: $caption)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .overlay(RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.black, lineWidth: 0.2))
                    .padding()
                Button("Take a Photo") {
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        self.isCameraPickerDisplayed.toggle()
                    } else {
                        print("Camera is not available")
                    }
                }.padding()

                Button("Choose a Photo") {
                    if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                        self.isPhotoLibraryPickerDisplayed.toggle()
                    } else {
                        print("Photo Library is not available")
                    }
                }.padding()


                VStack {
                    Text("Milestone?")
                    Toggle(isOn: $significant) {
                        EmptyView()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 80, alignment: .center)
                    .shadow(radius: 2)
                    .offset(x: -150)
                }
                .frame(maxWidth: .infinity, maxHeight: 150, alignment: .center) // Set frame to fill the available space
                .padding() // Add padding around the VStack
            }
            .navigationTitle("Add your Milestone")
            .fullScreenCover(isPresented: self.$isCameraPickerDisplayed, content: {
                Camera(selectedImage: self.$selectedImage, sourceType: .camera)
                    .edgesIgnoringSafeArea(.all)
            })
            .fullScreenCover(isPresented: self.$isPhotoLibraryPickerDisplayed, content: {
                Camera(selectedImage: self.$selectedImage, sourceType: .photoLibrary)
                    .edgesIgnoringSafeArea(.all)
            })
        }
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        AddMilestone()
            .environmentObject(Goal(name: "hi", date: Date(), color: Color.red))
    }
}
