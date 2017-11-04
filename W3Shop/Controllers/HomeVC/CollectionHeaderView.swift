//
//  CollectionHeaderView.swift
//  W3Shop
//
//  Created by ios2 on 11/1/17.
//  Copyright © 2017 W3Care. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    
    @IBOutlet weak var mens_btn: UIButton!
    @IBOutlet weak var women_Btn: UIButton!
    @IBOutlet weak var kid_btn: UIButton!
    @IBOutlet weak var offier_btn: UIButton!
 
    @IBOutlet weak var banner_image: UIImageView!
    
    @IBOutlet weak var mens_lbl: UILabel!
    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var slideControl: UIPageControl!
    
    @IBOutlet weak var sliderBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.mens_btn.layer.cornerRadius = mens_btn.frame.height / 2.0
        self.mens_btn.clipsToBounds = true
      
        self.women_Btn.layer.cornerRadius = women_Btn.frame.height / 2.0
        self.women_Btn.clipsToBounds = true
        
        self.kid_btn.layer.cornerRadius = kid_btn.frame.height / 2.0
        self.kid_btn.clipsToBounds = true
        
        self.offier_btn.layer.cornerRadius = offier_btn.frame.height / 2.0
        self.offier_btn.clipsToBounds = true
        
        
    }
    
}
