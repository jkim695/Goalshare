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
                HStack {
                    Spacer()
                    HStack {
                        ForEach(0..<slides.count) { index in
                            RoundedRectangle(cornerRadius: 5)
                                .fill(currentSlide == index ? Color.blue : Color.gray)
                                .frame(width: 10, height: 10)
                                .onTapGesture {
                                    withAnimation {
                                        currentSlide = index
                                    }
                                }
                        }
                    }
                    .padding(.top)
                    Spacer()
                }
                .offset(y: -50)
            }
        }
    }
}

