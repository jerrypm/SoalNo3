//
//  LsitContactViewController.swift
//  SoalNo3
//
//  Created by Jeri Purnama Maulid on 08/07/18.
//  Copyright © 2018 Jeri Purnama Maulid. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class LsitContactViewController: UIViewController {
    @IBOutlet weak var tableViewList: UITableView!
    
    let url = "http://dev.nostratech.com:10093/api/v1/person"
    var id: [String] = []
    var imagePicture: [String] = []
    var users: [String] = []
    var alamat: [String] = []
    var phone: [String] = []
    var email: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "List Contact"
        self.tableViewList.delegate = self
        self.tableViewList.dataSource = self
        self.tableViewList.rowHeight = UITableViewAutomaticDimension
        self.tableViewList.estimatedRowHeight = 150
        self.tableViewList.register(UINib(nibName: "ListContactTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: nil)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    print("dataList\(data)")
                    let dataJSON = JSON(data)
                    self.id = []
                    self.users = []
                    self.alamat = []
                    self.phone = []
                    self.email = []
                    dataJSON["result"].forEach({ (data2) in
                        let idI = data2.1["id"].string
                        let imageI = data2.1["picture"].string
                        let nameI = data2.1["name"].string
                        let alamatI = data2.1["address"].string
                        let phoneI = data2.1["phone"].string
                        let emailI = data2.1["email"].string
                        
                        self.id.append(idI!)
                        self.imagePicture.append(imageI!)
                        self.users.append(nameI!)
                        self.alamat.append(alamatI!)
                        self.phone.append(phoneI!)
                        self.email.append(emailI!)
                        
                    })
                
                    self.tableViewList.reloadData()
                    
                case .failure(let error):
                    print(error)
                }
           }
     }

}

extension LsitContactViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListContactTableViewCell

        cell.imageAdd.kf.setImage(with: URL(string: imagePicture[indexPath.row]))
        cell.namaAdd.text = "Nama: \(users[indexPath.row])"
        cell.alamatAdd.text = "Alamat: \(alamat[indexPath.row])"
        cell.phoneAdd.text = "Phone: \(phone[indexPath.row])"
        cell.emailAdd.text = "Email: \(email[indexPath.row])"
        
        return cell
    }
    
    // Untuk bagian Edit dan Delete
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            
            self.navigationController?.pushViewController(EditListViewController(), animated: true)
            UserDefaults.standard.set(self.id[indexPath.row], forKey: "dataId")
            print("Edit: \(self.id[indexPath.row])")
            

        })
        editAction.backgroundColor = UIColor.blue
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            
            let urlDelete = "http://dev.nostratech.com:10093/api/v1/person/\(self.id[indexPath.row])"
            Alamofire.request(urlDelete, method: .delete)
            print("Delete tapped")
        })
        deleteAction.backgroundColor = UIColor.red
        
        return [deleteAction, editAction]
      }
    
}
