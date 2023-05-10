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
        guard let fileUrl = Bundle.main.url(forResource: "pexels-mohan-reddy-4250244-1440x2160-60fps", withExtension: "mp4") else {
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
    var body: some View {
        ZStack {
            GeometryReader{ geo in
                PlayerView()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width, height: geo.size.height+100)
                    .edgesIgnoringSafeArea(.all)
                    .overlay(Color.black.opacity(0.2))
                    .edgesIgnoringSafeArea(.all)
            }
            
            VStack {
                Spacer()
                HorizontalSlideshow(slides: [
                    AnyView(Text(" Goalshare").font(.system(size:72)).foregroundColor(.white)),
                    AnyView(
                        VStack {
                            if (currentSlide == 1) {
                                GradualTrimAnimation(backgroundOpacity: 0, animationProgress: 0, animationProgress2: 0)
                            }
                            else {
                                GradualTrimAnimation(backgroundOpacity: 0, animationProgress: 0, animationProgress2: 0)
                                    .isHidden(true, remove: false)
                            }
                            Text("Keep track of your goals and progression throughout them").font(.title).foregroundColor(.white)
                        }),
                        ], currentSlide: $currentSlide)
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
    
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .isHidden(true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .isHidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
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
