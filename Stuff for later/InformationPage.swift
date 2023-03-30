//
//  SwiftUIView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 11/22/22.
//

import SwiftUI

struct InformationPage: View {
    @Namespace var namespace
    @State var show = true
    var body: some View {
        ZStack {
            if (show) {
                VStack (alignment: .center, spacing: 12){
                    Spacer()
                    Text("What is GoalShare?")
                        .font(.largeTitle.weight(.bold))
                        .matchedGeometryEffect(id: "title", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Spacer()
                    
                }
                .padding(20)
                .foregroundStyle(.white)
                .background(
                    Image("Background 4")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .matchedGeometryEffect(id: "background", in: namespace)
                )
                .mask(
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .matchedGeometryEffect(id: "mask", in: namespace))
                
            }
            else {
                VStack (alignment: .center, spacing: 12){
                    Text("What is GoalShare?")
                        .padding(.top, 50)
                        .font(.largeTitle.weight(.bold))
                        .matchedGeometryEffect(id: "title", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text(" - GoalShare is a more positive spin on social media. It is a platform where people can log and post about goals. ")
                    Text(" - Filler needs to be changed to be more fun and exciting bc IDK what to say")
                    Text("XDDDDDDDDDDDD")
                    Spacer()
                }
                .padding(20)
                .foregroundStyle(.white)
                .background(
                    Image("Background 4")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .matchedGeometryEffect(id: "background", in: namespace)
                )
                .mask(
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .matchedGeometryEffect(id: "mask", in: namespace))
            }
        }
        .ignoresSafeArea()
        .onTapGesture {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                show.toggle()
            }
        }
    }
    
        
    
}

struct InformationPage_previews: PreviewProvider {
    static var previews: some View {
        InformationPage()
    }
}
