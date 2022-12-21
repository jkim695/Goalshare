import SwiftUI

struct NewPostView: View {
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                if selectedImage != nil {
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
