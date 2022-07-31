//
//  ImageStorage.swift
//  iGallery
//
//  Created by Yu Hin Li on 31/7/2022.
//

import Foundation

class ImageStorage{
    
    static let imagesKey = "images"
    private let userDefaults: UserDefaults = UserDefaults.standard

    var images: [Data]{
        guard let images = userDefaults.array(forKey: Self.imagesKey) else{
            return []
        }
        
        return images.compactMap({ element in
            return element as? Data
        })
    }
    
    func saveImage(_ image: Data){
        guard !hasImage(image) else{
            return
        }
        var images = self.images
        images.append(image)
        userDefaults.set(images, forKey: Self.imagesKey)
    }

    func deleteImage(_ image: Data){
        guard hasImage(image) else{
            return
        }
        var images = self.images
        images.removeAll{ currentImage in
            return currentImage == image
        }
    }
    
    private func hasImage(_ image: Data) -> Bool{
        let images = self.images
        return images.contains(image)
    }
}
