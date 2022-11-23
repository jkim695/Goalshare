//
//  Profile.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 11/21/22.
//

import SwiftUI

/*
 * Matched geometry
 * Should be used on individual elements
 * Individual elements should keep their integrity
 * Should be able to reorder elements and should work same
 *
 */
struct MatchedGeometryTest: View {
    @Namespace var namespace
    @State var show = true
    var body: some View {
        ZStack {
            if (show) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("SwiftUI")
                        .font(.largeTitle.weight(.bold))
                        .matchedGeometryEffect(id: "title", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Amazing, just amazing".uppercased())
                        .font(.footnote.weight(.semibold))
                        .matchedGeometryEffect(id: "subtitle", in: namespace)
                    Text("Not really but...")
                        .font(.footnote)
                        .matchedGeometryEffect(id: "footnote", in: namespace)
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
                VStack (alignment: .trailing, spacing: 12){
                    Spacer()
                    Text("Not really but...")
                        .font(.footnote)
                        .matchedGeometryEffect(id: "footnote", in: namespace)
                    Text("Amazing, just amazing".uppercased())
                        .font(.footnote.weight(.semibold))
                        .matchedGeometryEffect(id: "subtitle", in: namespace)
                    Text("SwiftUI")
                        .font(.largeTitle.weight(.bold))
                        .matchedGeometryEffect(id: "title", in: namespace)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
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
        .onTapGesture {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                show.toggle()
            }
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        MatchedGeometryTest()
    }
}
