//
//  ListViewController.swift
//  iGallery
//
//  Created by Yu Hin Li on 31/7/2022.
//

import Foundation
import UIKit

final class ListViewController:UIViewController{
    private static let resuableCellID = "ImageCell"
    private let storage = ImageStorage()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    @IBAction func close(_ sender: Any) {
        navigationController?.dismiss(animated: true)
    }
    
}

extension ListViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.resuableCellID) as? ImageCell else{
            print("Cannot create the cell")
            return UITableViewCell()
        }
        cell.imageCell.image = UIImage(data: storage.images[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storage.images.count
    }
}

extension ListViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return tableView.frame.height
    }
    
}
