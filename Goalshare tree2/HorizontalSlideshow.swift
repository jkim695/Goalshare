//
//  HorizontalSlideshow.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 5/1/23.
//

import SwiftUI

struct HorizontalSlideshow: View {
    var slides: [AnyView]
    @Binding var currentSlide: Int

    var body: some View {
        
        GeometryReader { geometry in
            VStack {
                Spacer()
                TabView(selection: $currentSlide) {
                    ForEach(0..<slides.count) { index in
                        SlideView {
                            slides[index]
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .frame(height: geometry.size.height)
                Spacer()
            }
        }
    }
}

