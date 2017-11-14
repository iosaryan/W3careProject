//
//  colorCell.swift
//  W3Shop
//
//  Created by ios2 on 11/6/17.
//  Copyright © 2017 W3Care. All rights reserved.
//

import UIKit

class colorCell: UITableViewCell {

    @IBOutlet weak var colorName: UILabel!
    @IBOutlet weak var checkBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
