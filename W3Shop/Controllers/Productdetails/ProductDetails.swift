//
//  ProductDetails.swift
//  W3Shop
//
//  Created by ios2 on 9/27/17.
//  Copyright © 2017 W3Care. All rights reserved.
//

import UIKit
import CoreData
import AudioToolbox


class ProductDetails: UIViewController , UIScrollViewDelegate{
    
    
    let data = itemList()
    
    @IBOutlet weak var ProductName: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var Colortext: UILabel!
    @IBOutlet weak var DestriptionText: UILabel!
    @IBOutlet weak var DiscountPriceText: UILabel!
    
    @IBOutlet weak var ProductCategory: UILabel!
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var pageCtrl: UIPageControl!
    
    @IBOutlet weak var imageScrollView: UIScrollView!
    
    
    @IBOutlet weak var BGscrollView: UIScrollView!
    @IBOutlet weak var BGView: UIView!
    
    
    var ProductDetailsArray = [] as Array
    var productTitle       =  String()
    var productDescription = String()
    var productDetail_Description = String()
    var ProductPrice       = String()
    var productSalePrice   = String()
    var productColor       = String()
    var productCategory    = String()
   
    var ProductImage: UIImage!
    
    var imageViewObject = UIImageView()
    fileprivate var rightCount = 0
    var label = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Product Detail"
        
        imageScrollView.delegate = self
         let ArrCount = 4
         var xvalue = CGFloat()
        
        for i in 0 ..< ArrCount {
         
            //let xvalue = imageScrollView.frame.size.width
            
            if(Constant.SCREEN_WIDTH == 320){
                xvalue = 292
            }else if(Constant.SCREEN_WIDTH == 375) {
                xvalue = 347
            }else{
                xvalue = 386
            }
            
            //width 288
            imageViewObject = UIImageView(frame:CGRect(x: xvalue * CGFloat(i)  , y: 0, width: imageScrollView.frame.size.width , height: imageScrollView.frame.size.height-15))
            
            imageViewObject.contentMode = UIViewContentMode.scaleToFill
            imageViewObject.clipsToBounds = true
            imageViewObject.image = UIImage(named: data.sliderImage[i])
            imageScrollView.addSubview(imageViewObject)
        }
        
        imageScrollView.contentSize = CGSize(width:  imageScrollView.frame.size.width * 4  , height: imageScrollView.frame.size.height-15)
        
        //self.view.pageCtrl.numberOfPages = ArrCount
        pageCtrl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
        
        
        
        //IMG.image =  ProductImage
        ProductName.text = ("  \(productTitle)!")
        Price.text = ("Price: \(ProductPrice)!")
        Colortext.text  = ("product color: \(productDescription)!")
        DiscountPriceText.text = ("offer price: \(productSalePrice)!")
        ProductCategory.text = ("category: \(productCategory)!")
        DestriptionText.text = ("\(productDetail_Description)!")
        
        badgeBarButtomItem()
        
        
        //self.BGView.frame = CGRect (x:0 , y:0 , width:Constant.SCREEN_WIDTH , height:BGView.frame.height)
        //self.BGscrollView.contentSize = CGSize(width: self.BGView.frame.size.width  , height: self.view.frame.size.height)
        //self.BGscrollView.addSubview(BGView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         badgeBarButtomItem()
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
        
        //*** Bar button item
        let rightBarButtomItem = UIBarButtonItem(customView: rightButton)
        navigationItem.rightBarButtonItem = rightBarButtomItem
        
    }
    
    
    
    
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageCtrl.currentPage) * pageCtrl.frame.size.width
        imageScrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageWidth =  scrollView.frame.size.width
        let page = Int(floor(( scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        print("page = \(page)")
        pageCtrl.currentPage = page
    }
    
    
    
    
    @IBAction func buyNowBtn(_ sender: Any) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Cart", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "buyNowVC") as! buyNowVC
        //vc.productName = productTitle
        vc.productPrice = ProductPrice
        self.show(vc, sender: self)
        
        
    }
    
    @IBAction func addToCartBtn(_ sender: Any) {
        
       
        
        //*** check context already exist
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        let predicate = NSPredicate(format: "productname == %@", productTitle as  CVarArg)
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
                person.setValue(productTitle, forKey: "productname")
                person.setValue(Float(productSalePrice), forKey: "price")
                
                let UIimage = ProductImage
                let imageData: NSData = UIImagePNGRepresentation(UIimage!)! as NSData
                
                let ImageStr = imageData.base64EncodedString(options: .lineLength64Characters)
                person.setValue(ImageStr, forKey: "image")
                
                //****** save the object
                do {
                    try context.save()
                    print("saved!")
                    alert(message:productTitle , title:"Successfully added to cart" )
                    
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
                alert(message: productTitle, title:"Already in Cart" )
            }
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
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
