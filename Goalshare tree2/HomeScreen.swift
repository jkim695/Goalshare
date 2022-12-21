//
//  Tree.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 11/22/22.
//

import SwiftUI

struct HomeScreen: View {
    @Namespace var namespace
    @State var show = true
    @State var hi = 10
    var body: some View {
        ZStack {
            if (show) {
                VStack (alignment: .center, spacing: 12){
                    Text("GoalShare.")
                        .font(.largeTitle.weight(.bold))
                        .matchedGeometryEffect(id: "title", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("Dream, achieve, accomplish".uppercased())
                        .font(.footnote.weight(.semibold))
                        .matchedGeometryEffect(id: "subtitle", in: namespace)
                    
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
                
                .padding(20)
            }
            else {
                VStack (alignment: .center, spacing: 12){
                    Spacer()
                    Text("GoalShare.")
                        .font(.largeTitle.weight(.bold))
                        .matchedGeometryEffect(id: "title", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .center)
                    Text("Dream, achieve, accomplish".uppercased())
                        .font(.footnote.weight(.semibold))
                        .matchedGeometryEffect(id: "subtitle", in: namespace)
                    
                }
                .padding(50)
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

struct Tree_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
