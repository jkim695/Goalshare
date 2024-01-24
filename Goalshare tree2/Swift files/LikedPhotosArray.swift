//
//  LikedPhotosArray.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 1/24/24.
//

import Foundation
class LikedPhotosArray: ObservableObject {
    @Published var likedPhotos: [String]
    init(arr: [String]) {
        likedPhotos = arr
    }
}
