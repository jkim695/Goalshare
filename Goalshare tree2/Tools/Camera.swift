
import UIKit
import SwiftUI

struct Camera: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    var sourceType: UIImagePickerController.SourceType?
        
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        //imagePicker.sourceType = self.sourceType
        imagePicker.sourceType = sourceType ?? .photoLibrary
        imagePicker.delegate = context.coordinator // confirming the delegate
        imagePicker.modalPresentationStyle = .fullScreen // Present the camera in full-screen mode
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }

    // Connecting the Coordinator class with this struct
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}
