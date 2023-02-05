import SwiftUI

struct NewPostView: View {
    var tree: Tree
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State public var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    @State private var significant = true
    @State private var goesToDetail = false
    @State var chosen = false;
    var body: some View {
        NavigationStack {
            VStack {
                if selectedImage != nil {
                    NavigationLink(destination: tree, isActive: $goesToDetail) {
                        Button {
                            tree.milestones.append(Milestone(sig: significant, id: tree.milestones.count + 1, name: "filler", image: Image(uiImage: selectedImage!), date: "smth", caption: "hi"))
                            self.goesToDetail = true
                            
                            
                        } label: {
                            Text("ADD!")
                        }

                    }
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                        .frame(width: 300, height: 300)
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
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView(tree: Tree(goal: Goal(name: "hi", date: "smth", id: 1, milestones: [])))
    }
}
