//
//  itemList.swift
//  W3Shop
//
//  Created by ios2 on 9/27/17.
//  Copyright © 2017 W3Care. All rights reserved.
//

import UIKit




class itemList: NSObject {
    
    let productTitle: NSArray = [
        "Almond Toe Court Shoes",
        "Suede Shoes",
        "Leather Driver Saddle Loafers",
        "Flip Flops",
        "Flip Flops",
        "Gold Button Cardigan",
        "Cotton Shorts",
        "Fine Stripe Short Sleeve Shirt",
        "Fine Stripe Short Sleeve Shirt",
        "Sharkskin Waistcoat",
        "Lightweight Patch Pocket Blazer",
        "Bird Print Dress",
        "Mid Twist Cut-Out Dress",
        //*** category product
        "MENS LIFESTYLE HOODY",
        "SPORTSWEAR MEN'S LIFESTYLE DOWN JACKET DARK",
        "Champion Lifestyle Pullover Hoodie Navy & Oxford Grey Sweats & Hoodies",
        //*** womens
        "Woolen Cardigan",
        "Winter Wear for Women",
        //*** kids
        "Girls Party Wear-Diwali-Ethnic/Wedding",
        "Ethnic Wear Baby Boys Embroidered Sherwani",
        //*** other
        "class95cafes"
       
        ]
    
    let productDescription: [String] = [
        "Patent Black",
        "Blue",
        "Tan",
        "Red",
        "White",
        "Purple",
        "Medium Red",
        "Grey",
        "Green",
        "Charcoal",
        "Deer",
        "Black",
        "Pink",
        //*** category product
        "blue",
        "GREY/BLACK/WHITE",
        "dark blue",
        //*** womens
        "dark blue",
        "Black",
        //*** kids
        "Pink",
        "Blue and Maroon",
        //*** other
        "organic"
        ]
    
    let productDetail_Description: [String] = [
        "Denim was traditionally colored blue with indigo dye to make blue jeans, although  formerly denoted a different, lighter, cotton fabric.",
        "Jeans is considered casual wear and worn by men and women outside workplaces. Students cannot live without their basic 5 pocket jeans and hav",
       
        
        "Discover the ideal jeans fit to flatter your figure with our Denim Style Guide. Never envy great jeans again",
        "The ring-spun yarn produced by this method crates unique surface characteristics in the fabric, including unevenness",
        "Typical denim fabrics are woven from coarse, indigo-dyed cotton yarn. They are hard wearing, high density fabrics with a high mass per unit area.",
        "A shirt is a cloth garment for the upper body Originally an undergarment worn exclusively by men, it has become",
        "Medium Red",
        "Denim was traditionally colored blue with indigo dye to make blue jeans, although  formerly denoted a different, lighter, cotton fabric",
        "Looking to write more persuasive product descriptions? These 9 simple ... say you are going to add 6 new products to your website like a t-shirt",
        "A shirt is a cloth garment for the upper body Originally an undergarment worn exclusively by men, it has become",
        "Description T-Shirts from Spreadshirt ✓ Unique designs ✓ Easy 30 day return policy ✓ Shop Description T-Shirts now!",
        "Make your mark. Create your own personalised shirt, tailored to your precise measurements. Our design tools make it simple and fun to create that perfect tailor",
        "A dress shirt, button shirt, button-front, button-front shirt, or button-up shirt is a garment with a collar and a full-length opening at the front, which is fastened using",
        
        //*** category product
        "The MENS LIFESTYLE HOODY by sailfish is so cuddly that you will hardly want to take it off again – pure wearing comfort guaranteed! With this trendy hoody you will cut a fine figure everywher",
        "Sportswear Men's Down Jacket delivers lightweight warmth and protection from the elements. It's made with down insulation and a DWR (durable, water-repellent) coating so you can face the winter with confidence",
        "Champion Men Champion Lifestyle Pullover Hoodie Navy & Oxford Grey Sweats & Hoodies",
        //***womens
        "Keep your look lively wearing this coloured cardigan from the house of ewools (ludhiana hosiery). This cardigan is designed as per the latest trends and fashioned using quality wool.",
        "Women Hooded Long Section Wool Blend Jacket with Leather Ox Horn Shape Buckle",
        //*** kids
        "NeedyBee Girls Ready To Wear Stitched Designer Saree With Stitched Blouse. Fulfill your little girl, dream of dressing up just like you by gifting her this Designer saree. Beautified with neat Innovative wor",
        "Ethnic Sherwani and Brijish set will certainly make your son look absolutely stylish this festive and Wedding season. Features Ethnic Embroidery with Stone Studded Brooch on the Sherwani Kurta for a touch of traditional charm and a Dupion Silk Brijish",
         //*** other
       "Based on a 2000 USDA GAIN report, the organic market in the Philippines is just worth $6.2 million. However, it is estimated that this market is expanding by approximately 10 to 20 percent annually"
    ]

    
    
    let productCategory: [String] = ["Footwear", "Footwear", "Footwear", "Footwear", "Footwear", "Casualwear", "Casualwear", "Casualwear", "Casualwear", "Formalwear", "Formalwear", "Formalwear", "Formalwear",
         //*** category product
        "winterwear",
        "winterwear",
        "winterwear",
        "winterwear",
        "winterwear",
        "girlwear",
        "boyswear",
        "Other"
        ]
    
    let productImage: [String?] = ["pik1.jpeg", "w1.png", "w2.png", "w3.png", "w4.png", "w5.png", "rain4.jpg", "pik2.jpeg", "rain6.jpg", "rain5.jpg", "jay.jpg", "iohone1.jpg", "grooming1.jpg",
        //*** category product
        "mens_product1.jpg","mensproduct_2.jpg","mensProduct_3.jpg","women_product1.jpg","womens2.jpg",
        "kids_product1.jpg","kids_productBoy.jpeg","otherimage_kalingabrewed.jpg"
    ]
    
    let productPrice: [String?] = ["99.00", "42.00", "34.00", "19.00", "19.00", "167.00", "30.00", "49.99", "49.99", "75.00",                         "175.50", "270.00", "540.00",
        //*** category product
        "5000.00","2450.00","6000.00","1590.00", "1455.00","1799.00" ,"1921.00" , "200.00"
        ]
    
    let productSalePrice: [String] = ["99.00", "42.00", "34.00", "19.00", "29.00", "167.00", "30.00", "49.00", "39.00", "75.00",  "175.50", "270.00", "540.00",
        //*** category product
        "5000.00","2450.00","6000.00", "1590.00", "1455.00", "1799.00","1921.00", "200.00"
        ]
    
    //** for filter
   let productSalePriceInInteger: [Int] = [99, 42, 34, 19, 29, 167, 30, 49, 39, 75, 175, 270, 540,
                                           //*** category product
                                           5000,2450, 6000, 1590, 1455, 1799, 1921, 200
                                           ]
    
    
    // Banner Image
    let sliderImage  :[String] = ["slide_banner4.jpg" , "slidebanner-2.jpg" , "slide_banner3.jpg" , "banner_girl1.jpg" , "slide_banner5.jpg"]
    
    let bannerImage :[String?] = ["Banner_girl2.jpeg" , "banner2.jpg" , "banner1.jpg" , "banner_girl1.jpg" , "discount_image.jpg"]
   

}
