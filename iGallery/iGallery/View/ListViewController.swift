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
        tableView?.backgroundColor = UIColor(named: "Background Gray")
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
        cell.imageCell.contentMode = .scaleAspectFill

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(storage.images.count == 0){
            tableView.setEmptyView(title: "No Liked image")
        }else{
            tableView.restore()
        }
        return storage.images.count
    }
}

extension ListViewController: UITableViewDelegate{

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return tableView.frame.height
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete",handler: {(ac:UIContextualAction, view: UIView, success: (Bool)->Void) in
            
            //Delete Message from userDefault
            let image = self.storage.images[indexPath.item]
            self.storage.deleteImage(image)
            
            self.tableView?.reloadData()
            
            self.showConfirmation()
            
            success(true)
        })
        
        deleteAction.backgroundColor = .red
        let config =  UISwipeActionsConfiguration(actions: [deleteAction])
        return config
    }
    
    
    
    private func showConfirmation(){
        let alertController =  UIAlertController(title: "Success", message: "Image deleted!", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        action.setValue(UIColor(named:"Orange"),forKey: "titleTextColor")
        alertController.addAction(action)
        alertController.view.tintColor = UIColor(named: "orange")

        present(alertController,animated: true)
    }
}



//Empty State
extension UITableView{
    //Create an empty view contains label
    func setEmptyView(title: String){
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let titleLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "SF Pro", size: 15)
        titleLabel.textColor = UIColor.gray
        
        emptyView.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        
        titleLabel.text = title
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    //Restore view
    func restore(){
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
