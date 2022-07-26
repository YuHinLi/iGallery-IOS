//
//  RangdomImageGenerator.swift
//  iGallery
//
//  Created by Yu Hin Li on 31/7/2022.
//

import Foundation
import UIKit

class RandomImageGenerator{
    private static let endpoint = "https://picsum.photos"
    private static var setBound: Bool = false
    
    private var link: String!
    private var width: Int?
    private var height: Int?
    
    private var currentImage: Data?
    
    func generateImage(_ width: Int,_ height: Int, completion: @escaping (UIImage?) -> Void){
        if(!Self.setBound){
            link = Self.endpoint + "/\(width)/\(height)"
            Self.setBound = true
        }else if(width != self.width || height != self.height){
            link = Self.endpoint + "/\(width)/\(height)"
        }

        guard let url = URL(string: link) else{
            print("URL Error")
            completion(nil)
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data{
                let image = UIImage(data: data)
                self.currentImage = data
                completion(image)
            }else{
                print("Network Error")
                completion(nil)
            }
        }
        task.resume()
    }

    
    func getCurrentImage() -> Data?{
        return self.currentImage
    }
}
