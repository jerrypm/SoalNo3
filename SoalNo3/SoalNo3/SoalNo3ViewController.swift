//
//  SoalNo3ViewController.swift
//  SoalNo3
//
//  Created by Jeri Purnama Maulid on 07/07/18.
//  Copyright © 2018 Jeri Purnama Maulid. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class SoalNo3ViewController: UIViewController {
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var nama: UITextField!
    @IBOutlet weak var alamat: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var email: UITextField!
    
    @IBAction func addButton(_ sender: UIButton) {
            
            let urlLis = "http://dev.nostratech.com:10093/api/v1/person"
            
            let parameter: Parameters = [
                "name": nama.text ?? "",
                "address": alamat.text ?? "",
                "phone": phone.text ?? "",
                "email": email.text ?? ""
            ]
        
            let header = ["Content-Type": "application/json"]
            
            Alamofire.request(urlLis, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: header)
                .responseJSON { response in
                    print("isiLagi: \(response)")
                    switch response.result {
                    case .success(let data):
                        print("isi: \(data)")
                       
                    case .failure(let error):
    
                        print("Request failed with error: \(error)")
                    }
                }
    }
    
    @IBAction func listButton(_ sender: UIButton) {
        navigationController?.pushViewController(LsitContactViewController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
}
