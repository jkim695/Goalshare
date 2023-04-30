import SwiftUI

struct AddMilestone: View {
    @EnvironmentObject var goal: Goal
    @Environment(\.presentationMode) var presentationMode
    @State private var sourceType: UIImagePickerController.SourceType? = nil
    @State public var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    @State private var significant = true
    @State var chosen = false
    @State private var complete = false
    @State private var caption = ""
    @State private var isCameraDisplay = false
    @State private var isPhotoLibraryDisplay = false
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
//                Button("Take a Photo") {
//                    self.sourceType = .camera
//                    print("Take a Photo button tapped, sourceType: \(self.sourceType ?? .camera)")
//                    self.isImagePickerDisplay.toggle()
//                }.padding()
                Button("Take a Photo") {
                    self.sourceType = .camera
                    self.isCameraDisplay.toggle()
                }.padding()

//                Button("Choose a Photo") {
//                    self.sourceType = .photoLibrary
//                    print("Take a Photo button tapped, sourceType: \(self.sourceType ?? .photoLibrary)")
//                    self.isImagePickerDisplay.toggle()
//                }.padding()
                Button("Choose a Photo") {
                    self.sourceType = .photoLibrary
                    self.isPhotoLibraryDisplay.toggle()
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

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        AddMilestone()
            .environmentObject(Goal(name: "hi", date: Date(), color: Color.red))
    }
}
