//
//  ProductDetails.swift
//  W3Shop
//
//  Created by ios2 on 9/27/17.
//  Copyright © 2017 W3Care. All rights reserved.
//

import UIKit

class ProductDetails: UIViewController , UIScrollViewDelegate{
    
    
    @IBOutlet weak var IMG: UIImageView!
    @IBOutlet weak var ProductName: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var Colortext: UILabel!
    @IBOutlet weak var DestriptionText: UILabel!
    @IBOutlet weak var DiscountPriceText: UILabel!
    
    @IBOutlet weak var ProductCategory: UILabel!
    
    @IBOutlet weak var ScrollView: UIScrollView!
    
    @IBOutlet weak var BGView: UIView!
    
    
    var ProductDetailsArray = [] as Array
    var productTitle       =  String()
    var productDescription = String()
    var ProductPrice       = String()
    var productSalePrice   = String()
    var productColor       = String()
    var productCategory    = String()
    var ProductImage: UIImage!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Product Detail"
        

        
        IMG.image =  ProductImage
        ProductName.text = ("  product Name: \(productTitle)!")
        Price.text = ("Price: \(ProductPrice)!")
        Colortext.text  = ("product color: \(productDescription)!")
        DiscountPriceText.text = ("offer price: \(productSalePrice)!")
        ProductCategory.text = ("category: \(productCategory)!")
        DestriptionText.text = (" \(productDescription)!")
        

        ScrollView.contentSize = CGSize(width: BGView.frame.size.width , height: BGView.frame.height+1000)
        ScrollView.addSubview(BGView)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
