//
//  CartCell.swift
//  W3Shop
//
//  Created by ios2 on 9/27/17.
//  Copyright © 2017 W3Care. All rights reserved.
//

import UIKit

class CartCell: UITableViewCell {

    
    @IBOutlet weak var IMG: UIImageView!
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var buyNow: UIButton!
    @IBOutlet var Descriptiontext: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
