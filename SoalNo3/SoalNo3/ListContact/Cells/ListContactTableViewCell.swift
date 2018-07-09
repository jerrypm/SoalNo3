//
//  ListContactTableViewCell.swift
//  SoalNo3
//
//  Created by Jeri Purnama Maulid on 09/07/18.
//  Copyright © 2018 Jeri Purnama Maulid. All rights reserved.
//

import UIKit

class ListContactTableViewCell: UITableViewCell {
    @IBOutlet weak var imageAdd: UIImageView!
    @IBOutlet weak var namaAdd: UILabel!
    @IBOutlet weak var alamatAdd: UILabel!
    @IBOutlet weak var phoneAdd: UILabel!
    @IBOutlet weak var emailAdd: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
