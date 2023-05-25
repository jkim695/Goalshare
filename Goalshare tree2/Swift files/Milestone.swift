//
//  ImageView.swift
//  Goalshare tree2
//
//  Created by Joshua Kim on 12/22/22.
//

import SwiftUI
import Foundation
import SwiftUI
import CoreLocation
import FirebaseFirestore
import UIKit

class Milestone: ObservableObject, Identifiable {
    @Published var sig: Bool
    @Published var id: UUID
    @Published var name: String
    @Published var image: Image?
    @Published var date: Date
    @Published var caption: String
    @Published var imageUrl: URL?

    init(name: String, sig: Bool, image: Image, imageUrl: URL?, caption: String) {
        self.id = UUID()
        self.name = name
        self.sig = sig
        self.image = image
        self.date = Date()
        self.caption = caption
        self.imageUrl = imageUrl
    }
    init?(data: [String: Any]) {
        guard let name = data["name"] as? String,
              let imageUrlString = data["image"] as? String,
              let imageUrl = URL(string: imageUrlString),
              let timestamp = data["date"] as? Timestamp,
              let idString = data["id"] as? String,
              let id = UUID(uuidString: idString),
              let sig = data["sig"] as? Bool,
              let caption = data["caption"] as? String else {
            return nil
        }
        
        self.name = name
        self.date = timestamp.dateValue()
        self.id = id
        self.imageUrl = imageUrl
        self.caption = caption
        self.sig = sig
    }
    func downloadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                if let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert data to image."])))
                }
            }
        }.resume()
    }
    func loadImage() {
        downloadImage(from: self.imageUrl!) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.image = Image(uiImage: image)
                }
            case .failure(let error):
                print("Error downloading image: \(error)")
            }
        }
    }

}
