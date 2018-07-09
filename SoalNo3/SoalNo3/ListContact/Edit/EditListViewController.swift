//
//  EditListViewController.swift
//  SoalNo3
//
//  Created by Jeri Purnama Maulid on 09/07/18.
//  Copyright © 2018 Jeri Purnama Maulid. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class EditListViewController: UIViewController {
    @IBOutlet weak var namaText: UITextField!
    @IBOutlet weak var alamatText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    let url = "http://dev.nostratech.com:10093/api/v1/person/\(UserDefaults.standard.string(forKey: "dataId") ?? "")"
    
    @IBAction func editButton(_ sender: UIButton) {
        
        let parameter: Parameters = [
            "name": namaText.text ?? "",
            "address": alamatText.text ?? "",
            "phone": phoneText.text ?? "",
            "email": emailText.text ?? ""
        ]
        
        let header = ["Content-Type": "application/json"]
        
        Alamofire.request(url, method: .put, parameters: parameter, encoding: JSONEncoding.default, headers: header)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                    print("Ok: \(data)")
                    
                case .failure(let error):
                    print(error)
                }
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.queryString, headers: nil)
            .responseJSON { response in
                switch response.result {
                case .success(let data):
                  
                    let dataJSON = JSON(data)
                    dataJSON["result"].forEach({ (data2) in
                        let nameI = data2.1["name"].string
                        let alamatI = data2.1["address"].string
                        let phoneI = data2.1["phone"].string
                        let emailI = data2.1["email"].string
                        
                        self.namaText.text = nameI
                        self.alamatText.text = alamatI
                        self.phoneText.text = phoneI
                        self.emailText.text = emailI
                        
                    })
                    
                    
                case .failure(let error):
                    print(error)
                }
        }
        
     
    }

}
