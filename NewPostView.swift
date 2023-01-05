import SwiftUI

struct NewPostView: View {
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    @State private var significant = true
    
    var body: some View {
        NavigationStack {
            VStack {
                if selectedImage != nil {
                    var milestones: [Milestone] = []
                    NavigationLink(destination: Tree(goal: Goal(name: "name", date: "date", id: 1, milestones: milestones))) {
                        Text("hi")
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
            .navigationBarTitle("Post to your GoalTree!")
            .sheet(isPresented: self.$isImagePickerDisplay) {
                Camera(selectedImage: self.$selectedImage, sourceType: self.sourceType)
            }
            
        }
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}
