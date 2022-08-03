//
//  ImageCell.swift
//  iGallery
//
//  Created by Yu Hin Li on 31/7/2022.
//

import Foundation
import UIKit

class ImageCell:UITableViewCell{
    @IBOutlet var imageCell: UIImageView!
    
    func displayImage(forImage imageForDisplay:UIImage){
        imageCell.image = imageForDisplay
    }
}
