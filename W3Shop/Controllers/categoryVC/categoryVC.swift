//
//  categoryVC.swift
//  W3Shop
//
//  Created by ios2 on 11/27/17.
//  Copyright © 2017 W3Care. All rights reserved.
//

import UIKit
import CoreData
import AudioToolbox

class categoryVC: UIViewController  ,UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    let data = itemList()
    let reuseIdentifier = "HomeCell"
    
    var caregorytitle =   String()
    var TagValue = Int()
    
    let trans = [] as Array
    fileprivate var rightCount = 0
    var label = UILabel()
    
     var productTitle = [String!]()
     var productPrice = [String]()
     var productDescription = [String]()
     var productDetail_Description = [String]()
     var productfinalPrice = [String!]()
     var productCategory = [String]()
     var productImage = [String?]()
    
   

    @IBOutlet weak var category_Table: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.title =  caregorytitle
        
       
        //i am using xibs:
        self.category_Table!.register(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.category_Table.delegate = self
        self.category_Table.dataSource = self
        self.category_Table.allowsSelection = true
        self.category_Table.isUserInteractionEnabled = true
        
        if TagValue == 1{
            
            productTitle = ["MENS LIFESTYLE HOODY",
                            "SPORTSWEAR MEN'S LIFESTYLE DOWN JACKET DARK",
                            "Champion Lifestyle Pullover Hoodie Navy & Oxford Grey Sweats & Hoodies"]
            
            productPrice = [ "5000.00","2450.00","6000.00","1590.00", "1455.00","1799.00" ,"1921.00" , "200.00"]
            
            productDetail_Description = ["The MENS LIFESTYLE HOODY by sailfish is so cuddly that you will hardly want to take it off again – pure wearing comfort guaranteed! With this trendy hoody you will cut a fine figure everywher",
                                         "Sportswear Men's Down Jacket delivers lightweight warmth and protection from the elements. It's made with down insulation and a DWR (durable, water-repellent) coating so you can face the winter with confidence",
                                         "Champion Men Champion Lifestyle Pullover Hoodie Navy & Oxford Grey Sweats & Hoodies"]
            
            productDescription = ["blue","GREY/BLACK/WHITE","dark blue",]
            productCategory    = ["winterwear","winterwear","winterwear",]
            productfinalPrice  = ["5000.00","2450.00","6000.00"]
            productImage       = ["mens_product1.jpg","mensproduct_2.jpg","mensProduct_3.jpg"]
            
            
        }else if TagValue == 2{
            
            productTitle = ["Woolen Cardigan","Winter Wear for Women",]
            
            productPrice = ["1590.00", "1455.00"]
            productDescription = ["dark blue","Black",]
            
            productDetail_Description = ["Keep your look lively wearing this coloured cardigan from the house of ewools (ludhiana hosiery). This cardigan is designed as per the latest trends and fashioned using quality wool.",
                                         "Women Hooded Long Section Wool Blend Jacket with Leather Ox Horn Shape Buckle"]
            productCategory = ["winterwear",
                               "winterwear",]
            productfinalPrice = ["1455.00","1799.00"]
            productImage = ["women_product1.jpg","womens2.jpg"]
            
        }else if TagValue == 3{
            
            productTitle = ["Girls Party Wear-Diwali-Ethnic/Wedding",
                            "Ethnic Wear Baby Boys Embroidered Sherwani"]
            
            productPrice = ["1799.00" ,"1921.00" ]
            
            productDescription = ["Pink","Blue and Maroon"]
            
            productDetail_Description = ["NeedyBee Girls Ready To Wear Stitched Designer Saree With Stitched Blouse. Fulfill your little girl, dream of dressing up just like you by gifting her this Designer saree. Beautified with neat Innovative wor",
                                         "Ethnic Sherwani and Brijish set will certainly make your son look absolutely stylish this festive and Wedding season. Features Ethnic Embroidery with Stone Studded Brooch on the Sherwani Kurta for a touch of traditional charm and a Dupion Silk Brijish"]
            
            productCategory = ["girlwear","boyswear",]
            productfinalPrice = [ "1799.00","1921.00"]
            productImage = [ "kids_product1.jpg","kids_productBoy.jpeg"]
            
        }else {
            
            productTitle = ["class95cafes"]
            productPrice = ["200.00"]
            productDescription = ["organic"]
            productDetail_Description = ["Based on a 2000 USDA GAIN report, the organic market in the Philippines is just worth $6.2 million. However, it is estimated that this market is expanding by approximately 10 to 20 percent annually"]
            productCategory = ["Other"]
            productfinalPrice = ["200.00"]
            productImage = ["otherimage_kalingabrewed.jpg"]
        }
        
        self.category_Table.reloadData()
        
    }

    override func viewWillAppear(_ animated: Bool) {
         self.badgeBarButtomItem()
    }
    
    // MARK: - CollectionView Delegate & DataSourse Method
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productTitle.count
    }
    
    // MARK: - UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.size.width / 2.0-10, height: 208)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCell
        
        cell.Productname.text = (productTitle[indexPath.row] )
        cell.IMG.image        = UIImage(named: productImage[indexPath.row]! )
        cell.colorText.text   = productDescription[indexPath.row] as String
        
        cell.priceText.text   = "Rs" + String(describing: (productPrice[indexPath.row] ))
        cell.AddtoCartBtn.tag = indexPath.row
        cell.screenBtn.tag = indexPath.row
        cell.AddtoCartBtn.addTarget(self, action: #selector(AddtoCartBtn), for: UIControlEvents.touchUpInside)
        cell.screenBtn.addTarget(self , action: #selector (screenBtnPress) , for: UIControlEvents.touchUpInside)
        
        return cell
        
    }
    
    @objc func screenBtnPress(_ sender : UIButton){
        
        let ViewController = ProductDetails()
        ViewController.productTitle  =  productTitle[sender.tag]
        ViewController.ProductPrice = "Rs" + productPrice[sender.tag]
        ViewController.productSalePrice = "Rs" + productPrice[sender.tag]
        ViewController.ProductImage  = UIImage(named: productImage[sender.tag]!)
        ViewController.productDescription = productDescription[sender.tag]
        ViewController.productDetail_Description = productDetail_Description[sender.tag]
        ViewController.productCategory =  productCategory[sender.tag]
        
        self.navigationController?.pushViewController(ViewController, animated: true)
    }
    
    @objc func AddtoCartBtn(_ sender : UIButton){
        //*** check context already exist
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        let predicate = NSPredicate(format: "productname == %@", productTitle[sender.tag] as  CVarArg)
        request.predicate = predicate
        request.fetchLimit = 1
        
        do{
            let context = getContext()
            
            let count = try context.count(for: request)
            if(count == 0){
                //***  no matching object
                print("no present")
                
                //*** retrieve the entity that we just created
                let entity =  NSEntityDescription.entity(forEntityName: "Person", in: context)
                
                let person = NSManagedObject(entity: entity!, insertInto: context)
                //*** set the entity values
                person.setValue( productTitle[sender.tag], forKey: "productname")
                person.setValue(Float(productPrice[sender.tag]), forKey: "price")
                
                let UIimage = UIImage(named: productImage[sender.tag]!)
                let imageData: NSData = UIImagePNGRepresentation(UIimage!)! as NSData
                
                let ImageStr = imageData.base64EncodedString(options: .lineLength64Characters)
                person.setValue(ImageStr, forKey: "image")
                
                //****** save the object
                do {
                    try context.save()
                    print("saved!")
                    alert(message: productTitle[sender.tag] , title:"Successfully added to cart" )
                    
                    //**** update cart count
                    rightCount = rightCount + 1
                    label.text = String(rightCount)
                    print(label.text!)
                    
                    let defaults = UserDefaults.standard
                    defaults.set(rightCount, forKey: "CartCount")
                    defaults.synchronize()
                    
                    // *** vibrate device when add product to cart
                    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                    
                    badgeBarButtomItem()
                    
                    
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                } catch {}
            }
            else{
                //*** at least one matching object exists
                print("one matching item found")
                alert(message: productTitle[sender.tag] as String, title:"Already in Cart" )
            }
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
    }
    
    
    func badgeBarButtomItem()  {
        
        //*** button item
        let image = UIImage(imageLiteralResourceName: "cart")
        let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
        rightButton.setBackgroundImage(image, for: .normal)
        rightButton.addTarget(self, action: #selector(GotoCart), for: .touchUpInside)
        
        // *** Animation
        UIView.animate(withDuration: 0.6,
                       animations: {
                        rightButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.6) {
                            rightButton.transform = CGAffineTransform.identity
                        }
        })
        
        //*** key exist
        if UserDefaults.standard.object(forKey: "CartCount") != nil{
            
            //*** badge label
            label = UILabel(frame: CGRect(x: 10, y: -10, width: 20, height: 20))
            label.layer.borderColor = UIColor.clear.cgColor
            label.layer.borderWidth = 2
            label.layer.cornerRadius = label.bounds.size.height / 2
            label.textAlignment = .center
            label.layer.masksToBounds = true
            label.font = UIFont(name: "SanFranciscoText-Light", size: 13)
            label.textColor = .black
            label.backgroundColor = .white
            
            rightCount  = (UserDefaults.standard.value(forKey: "CartCount")! as! Int)
            
            if rightCount == 0{
                
            }else{
                
                self.label.text = String(rightCount)
                
                rightButton.addSubview(label)
            }
            
        }
        else {
            //*** not exist
        }
       
        let rightBarButtomItem  = UIBarButtonItem(customView: rightButton)
        //*** Bar button item
        let barButton_array: [UIBarButtonItem] = [rightBarButtomItem  ]
        navigationItem.setRightBarButtonItems(barButton_array, animated: false)
        
    }
    
    @objc func GotoFilter(_ sender : UIButton){
        
        let ViewController = FilterVC()
        self.navigationController?.pushViewController(ViewController, animated: true)
    }
    
    @objc func GotoCart(_ sender: UIButton){
        
        let storyboard = UIStoryboard(name: "Cart", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "addtoCart")
        vc.hidesBottomBarWhenPushed = true
        self.navigationController!.pushViewController(vc, animated: true)
        
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
