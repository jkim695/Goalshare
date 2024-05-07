//
//  IntroductionVideo.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 5/1/23.
//

import SwiftUI
import AVKit
import AVFoundation

struct PlayerView: UIViewRepresentable {
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
    }
    
    func makeUIView(context: Context) -> UIView {
        return LoopingPlayerUIView(frame: .zero)
    }
}
class LoopingPlayerUIView: UIView {
    private let playerLayer = AVPlayerLayer()
    private var playerLooper: AVPlayerLooper?
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Load the resource -> h
        guard let fileUrl = Bundle.main.url(forResource: "pexels-swisshumanity-stories-13709224 (1080p)", withExtension: "mp4") else {
            print("Error: Could not find 'intro.mov' in the app bundle.")
            return
        }
        let asset = AVAsset(url: fileUrl)
        let item = AVPlayerItem(asset: asset)
        // Setup the player
        let player = AVQueuePlayer()
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspect
        layer.addSublayer(playerLayer)
        // Create a new player looper with the queue player and template item
        playerLooper = AVPlayerLooper(player: player, templateItem: item)
        player.volume = 0
        // Start the movie
        player.play()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
}
struct IntroductionVideo: View {
    @Environment(\.presentationMode) var presentationMode
    @State var currentSlide = 0
    @State var animationDone = false
    @State var op = 0.0
    var body: some View {
        ZStack {
            GeometryReader{ geo in
                PlayerView()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:geo.size.width, height: geo.size.height + 200)
                    .edgesIgnoringSafeArea(.all)
                    .overlay(Color.black.opacity(0.2))
                    .edgesIgnoringSafeArea(.all)
            }
            VStack {
                Spacer()
                HorizontalSlideshow(slides: [
                    AnyView(
                        GeometryReader() { geometry in
                            VStack {
                                Spacer()
                                Image("Image")
                                    .resizable()
                                    .opacity(op)
                                    .frame(width: 200, height: 200)
                                    .onAppear {
                                        withAnimation(.snappy(duration: 2)) {
                                            op = 1.0
                                        }
                                    }
                                Text(" Goalshare").font(.system(size:72,weight: Font.Weight.semibold))
                                    .foregroundColor(.yellow)
                                Text("Your one stop shop for everything you need to accomplish your goals.")
                                    .font(.system(size: 24, weight: Font.Weight.medium))
                                    .foregroundColor(.white)
                                    .frame(width: geometry.size.width / 1.1)
                                Spacer()
                            }
                            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        }),
                    AnyView(
                        VStack (alignment: .leading, spacing: 10) {
                            Spacer()
                            Text("Intention and consistency?")
                                .font(.system(size: 28, weight: Font.Weight.bold))
                                .foregroundColor(.white)
                                .padding(.leading)
                            Text("We've all heard of the importance of goal-setting but how often do we intentionally and consistenly apply this practice, rather than letting our goals take a backseat in our lives?")
                                .font(.system(size: 24, weight: Font.Weight.semibold)).foregroundColor(.white)
                                .padding(.leading)
                        }),
                    AnyView(
                        GeometryReader { geometry in
                            VStack {
                                if (currentSlide == 2 || animationDone) {
                                    GradualTrimAnimation(backgroundOpacity: 0, animationProgress: 0, animationProgress2: 0)
                                        .onAppear { animationDone = true }
                                }
                                else {
                                    GradualTrimAnimation(backgroundOpacity: 0, animationProgress: 0, animationProgress2: 0)
                                        .isHidden(true)
                                }
                                Text("With Goalshare, you can harness the power of goalsetting by logging your progress and staying conisistent until you accomplish your goals.").font(.system(size: 24, weight: Font.Weight.semibold)).foregroundColor(.white)
                                    .padding(.top)
                            }
                        }),
                    AnyView(VStack {
                        Spacer()
                        Button (action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Let's get started!")
                                .foregroundColor(.black)
                                .font(.system(size: 24, weight: Font.Weight.semibold))
                                .padding(.vertical, 30.0)
                                .padding(.horizontal, 15)
                                .background(.yellow)
                                .cornerRadius(10)
                        }
                        Text("Ready to start maximizing the power of goalsetting?")
                            .font(.system(size: 24,weight: Font.Weight.semibold))
                            .foregroundStyle(.white)
                        
                        
                    }
                           )
                ], currentSlide: $currentSlide)
                ZStack {
                    Text("              ")
                        .padding(8)
                        .background(.gray)
                        .opacity(0.3)
                        .cornerRadius(8)
                    Text(" " + String(currentSlide + 1) + " / 4 ")
                        .font(.system(size: 20))
                        .bold()
                        .foregroundColor(.white)
                        .animation(Animation.easeIn(duration: 0.3))
                    
                }
                .padding(.top)
                
                
            }
        }
    }
}

struct IntroductionVideo_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionVideo()
    }
}
extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
