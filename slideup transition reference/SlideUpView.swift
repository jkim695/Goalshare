import SwiftUI

struct SlideUpView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.gray)
                    }
                    .padding()
                    Spacer()
                }
                
                Text("Slide Up View")
                    .font(.largeTitle)
                    .padding(.bottom)
                
                Spacer()
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
        }
    }
}
