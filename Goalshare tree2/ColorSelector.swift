//
//  ColorSelector.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 4/1/23.
//

import SwiftUI

struct ColorSelector: View {
    @State var selectedColor: Color
    let colors: [Color] = [.red, .blue, .green, .yellow, .orange, .purple]

    var body: some View {
        HStack(spacing: 40) {
            ForEach(colors.indices) { index in
                Circle()
                    .fill(colors[index])
                    .frame(width: 25, height: 25)
                    .overlay(
                        Circle()
                            .stroke(selectedColor == colors[index] ? Color.black : Color.clear, lineWidth: 2)
                    )
                    .onTapGesture {
                        selectedColor = colors[index]
                    }
            }
        }
    }
}

struct ColorSelector_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelector(selectedColor: .red)
    }
}
