import SwiftUI

struct BubbleView: View {
    let text: String
    let backgroundColor: Color
    let textColor: Color

    var body: some View {
        Text(text)
            .font(.system(size: 16))
            .padding(10)
            .background(backgroundColor)
            .foregroundColor(textColor)
            .clipShape(BubbleShape())
    }
}

struct BubbleShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight, .bottomLeft], cornerRadii: CGSize(width: 16, height: 16))
        return Path(path.cgPath)
    }
}

struct BubbleView_preview: PreviewProvider {
    static var previews: some View {
        BubbleView(text: "hasdifjuasfjl;dksajfklads;fjkld;sfi", backgroundColor: .green, textColor: .purple)
    }
}
