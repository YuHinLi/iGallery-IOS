//
//  ViewController.swift
//  iGallery
//
//  Created by Yu Hin Li on 23/7/2022.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var imageView: UIImageView!
    private let generator = RandomImageGenerator()
    private let storage = ImageStorage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        generateImage()
    }

    @IBAction func dislike(_ sender: Any) {
        generateImage()
        print("Dislike")
    }
    
    @IBAction func like(_ sender: Any) {

        if let currentImage = generator.getCurrentImage(){
            storage.saveImage(currentImage)
            print("Image stored")
        }
        	
        generateImage()
        print("Like")
    }
    
    private func generateImage(){
        let width: Int = Int(imageView.bounds.width)
        let height: Int = Int(imageView.bounds.height)
        
        generator.generateImage(width,height, completion: { image in
            if let image = image {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }else{
                //Todo print error
                DispatchQueue.main.async {
                    self.netWorkError()
                }
            }
        })
    }
    
    private func netWorkError(){
        let netWorkAlert = UIAlertController(title: "Error", message: "Something is wrong with your internet connection!", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default)
        
        netWorkAlert.addAction(ok)
        self.present(netWorkAlert, animated: true)
    }
}

