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
    @Published var imageUrlString: String?

    init(name: String, sig: Bool, image: Image, imageUrlString: String?, caption: String) {
        self.id = UUID()
        self.name = name
        self.sig = sig
        self.image = image
        self.date = Date()
        self.caption = caption
        self.imageUrlString = imageUrlString
    }
    init?(data: [String: Any]) throws {
        print("run")
        guard let name = data["name"] as? String,
              let imageUrlString = data["image"] as? String,
              let timestamp = data["date"] as? Timestamp,
              let idString = data["id"] as? String,
              let id = UUID(uuidString: idString),
              let sig = data["sig"] as? Bool,
              let caption = data["caption"] as? String else {
            throw MyError.invalidData
        }

        self.name = name
        self.date = timestamp.dateValue()
        self.id = id
        self.imageUrlString = imageUrlString
        self.caption = caption
        self.sig = sig
        self.image = nil
        

    }

    func loadImage() {
        
        guard let imageUrlString = self.imageUrlString else {
            print("Invalid image URL string.")
            return
        }
        print("Downloading image from \(imageUrlString)")
        downloadImage(from: imageUrlString) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    print("Image downloaded successfully.")
                    self.image = Image(uiImage: image)
                }
            case .failure(let error):
                print("Error downloading image: \(error)")
            }
        }
    }
    func downloadImage(from urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        print("Image URL: \(urlString)") // Check the URL string
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL string."])))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    print("Error in downloading image: \(error)") // Check if there's an error while downloading
                    completion(.failure(error))
                }
            } else if let data = data {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        print("Image downloaded successfully") // Check if image is downloaded successfully
                        completion(.success(image))
                    }
                } else {
                    DispatchQueue.main.async {
                        print("Failed to convert data to image") // Check if there's an issue with data-to-UIImage conversion
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to convert data to image."])))
                    }
                }
            }
        }.resume() // Call resume to start the URLSessionDataTask
    }


    enum MyError: Error {
        case invalidData
    }

}
