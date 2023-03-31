import SwiftUI

struct AddMilestone: View {
    @EnvironmentObject var goal: Goal
    @Environment(\.presentationMode) var presentationMode
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State public var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    @State private var significant = true
    @State var chosen = false
    @State private var complete = false
    var body: some View {
        VStack {
            if selectedImage != nil {
//                Button( action: {
//                    goal.milestones.append(Milestone(name: "", sig: true, image: Image(uiImage: selectedImage!), date: "", caption: ""))
//                    presentationMode.wrappedValue.dismiss()
//                }) {
//                    Text("Add Milestone")
//                }
                NavigationLink(destination: Tree()
                    .environmentObject(goal)
.onAppear(perform: {
                    goal.milestones.append(Milestone(name: "", sig: true, image: Image(uiImage: selectedImage!), date: "", caption: ""))
                }), isActive: $complete) {
                    EmptyView()
                }
                               Button( action: {
                                   print("HI \(goal.milestones.count)")
                    goal.milestones.append(Milestone(name: "", sig: true, image: Image(uiImage: selectedImage!), date: "", caption: ""))
//                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Add Milestone")
                }

                                                            
                                                            
//                Image(uiImage: selectedImage!)
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .clipShape(Circle())
//                    .frame(width: 300, height: 300)
            } else {
                Image("fedW")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(width: 300, height: 300)
            }

            Button("Take a Photo") {
                self.sourceType = .camera
                self.isImagePickerDisplay.toggle()
            }.padding()

            Button("Choose a Photo") {
                self.sourceType = .photoLibrary
                self.isImagePickerDisplay.toggle()
            }.padding()

            Toggle("Milestone?", isOn: $significant)
        }
        .navigationTitle("Add your Milestone")
        .sheet(isPresented: self.$isImagePickerDisplay) {
            Camera(selectedImage: self.$selectedImage, sourceType: self.sourceType)
        }
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        AddMilestone()
            .environmentObject(Goal(name: "hi", date: Date(), image: Image(systemName: "photo")))
    }
}
