//
//  RangdomImageGenerator.swift
//  iGallery
//
//  Created by Yu Hin Li on 31/7/2022.
//

import Foundation
import UIKit

class RandomImageGenerator{
    static var endpoint = "https://picsum.photos"
    static var setBound: Bool = false
    static var currentImage: Data?
    
    func generateImage(_ width: Int,_ height: Int, completion: @escaping (UIImage?) -> Void){
        if(!Self.setBound){
            Self.endpoint += "/\(width)/\(height)"
            Self.setBound = true
        }
        guard let url = URL(string: Self.endpoint) else{
            completion(nil)
            print("URL Error")
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data{
                let image = UIImage(data: data)
                Self.currentImage = data
                completion(image)
            }else{
                print("Task Error")
                completion(nil)
            }
        }
        task.resume()
    }
    
    func currentImage() -> Data?{
        return Self.currentImage
    }
}
