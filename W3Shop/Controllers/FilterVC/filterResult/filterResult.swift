//
//  filterResult.swift
//  W3Shop
//
//  Created by ios2 on 11/6/17.
//  Copyright © 2017 W3Care. All rights reserved.
//

import UIKit
import CoreData
import AudioToolbox

class filterResult: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{

    let data = itemList()
    let reuseIdentifier = "HomeCell"
    
    let trans = [] as Array
    fileprivate var rightCount = 0
    var label = UILabel()
    
     var color   = String()
     var filtered:[String] = []
     var searchActive : Bool = false
    
     var priceFilter =  Array<Int>()
    
     // *** when Price Filtered apend value
     var product_name = Array<Any>()
     var product_color = Array<Any>()
     var product_image = Array<Any>()
    
    @IBOutlet weak var filter_Collection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //i am using xibs:
        self.filter_Collection!.register(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        
        /* Setup delegates */
        self.filter_Collection.delegate = self
        self.filter_Collection.dataSource = self
        self.filter_Collection.allowsSelection = true
        self.filter_Collection.isUserInteractionEnabled = true
        
        print(priceFilter)
        print(color)
       
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        badgeBarButtomItem()
        if (priceFilter.count)>0{
            searchActive = false
            
            /// *** append comman value after filter
            var INDEX =  IndexPath()
            for price in priceFilter {
                
                let Index = data.productSalePriceInInteger.index(of: price )
                
                INDEX = IndexPath(row: Index!, section: 0)
                print(INDEX)
                
                print((data.productTitle[Index!] ))
                product_name.append((data.productTitle[Index!] ))
                product_color.append((data.productDescription[Index!] ))
                product_image.append(data.productImage[Index!] as Any)
                
            }
            
            self.filter_Collection.reloadData()
            
            
            
        }else{
            filter_item()
            
           
            
            self.filter_Collection.reloadData()
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
    
    
    // MARK: - CollectionView Delegate & DataSourse Method
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(searchActive) {
            return filtered.count
            
        }else {
            return priceFilter.count
        }
        
    }
    
    // MARK: - UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: self.view.frame.size.width / 2.0-13, height: 208)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCell
        
        if(searchActive){
            
            for color in filtered {
                
                let Index = data.productDescription.index(of: color)
                
                cell.Productname.text = (data.productTitle[Index!] as? String)
                cell.IMG.image        = UIImage(named: data.productImage[Index!]!)
                cell.priceText.text   = "Rs" + data.productSalePrice[Index!]
            }
                cell.colorText.text   = filtered[indexPath.row]
                cell.AddtoCartBtn.tag = indexPath.row
                cell.AddtoCartBtn.addTarget(self, action: #selector(AddtoCartBtn), for: UIControlEvents.touchUpInside)
            
        } else {
            
            
            cell.Productname.text = (product_name[indexPath.row] as! String )
            cell.IMG.image        = UIImage(named: product_image[indexPath.row] as! String)
            cell.colorText.text   = product_color[indexPath.row] as? String
            
            cell.priceText.text   = "Rs" + String((priceFilter[indexPath.row] ))
            cell.AddtoCartBtn.tag = indexPath.row
            cell.AddtoCartBtn.addTarget(self, action: #selector(AddtoCartBtn), for: UIControlEvents.touchUpInside)
        }
        
      
        
        
       
       
        
        return cell
        
        
    }
    
    
    // MARK: - UICollectionViewDelegate protocol
    func collectionView(_collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
    
    func filter_item()  {
        
        filtered.removeAll(keepingCapacity: false)
        
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", color)
        let array = (data.productDescription as NSArray).filtered(using: searchPredicate)
        filtered = array as! [String]
        
        
        
        searchActive = true;
        
        self.filter_Collection.reloadData()
       
    }
    
    
    
   
    
    @objc func AddtoCartBtn(_ sender : UIButton){
        //*** check context already exist
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        var predicate = NSPredicate()
        if (priceFilter.count)>0 {
         predicate = NSPredicate(format: "productname == %@", product_name[sender.tag] as!  CVarArg)
        } else {
          predicate = NSPredicate(format: "productname == %@", data.productTitle[sender.tag] as!  CVarArg)
        }
        
       
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
                if (priceFilter.count)>0 {
                    
                    person.setValue(product_name[sender.tag], forKey: "productname")
                    person.setValue(Float(priceFilter[sender.tag]), forKey: "price")
                    let UIimage = UIImage(named: product_image[sender.tag] as! String)
                    let imageData: NSData = UIImagePNGRepresentation(UIimage!)! as NSData
                    
                    let ImageStr = imageData.base64EncodedString(options: .lineLength64Characters)
                    person.setValue(ImageStr, forKey: "image")
                } else {
                    
                    person.setValue(data.productTitle[sender.tag], forKey: "productname")
                    person.setValue(Float(data.productSalePrice[sender.tag]), forKey: "price")
                    
                    let UIimage = UIImage(named: data.productImage[sender.tag]!)
                    let imageData: NSData = UIImagePNGRepresentation(UIimage!)! as NSData
                    
                    let ImageStr = imageData.base64EncodedString(options: .lineLength64Characters)
                    person.setValue(ImageStr, forKey: "image")
                }
                
               
                
                
                //****** save the object
                do {
                    try context.save()
                    print("saved!")
                    
                    if (priceFilter.count)>0 {
                        alert(message: product_name[sender.tag] as! String, title:"Successfully added to cart" )
                        }else{
                            alert(message: data.productTitle[sender.tag] as! String, title:"Successfully added to cart" )
                        }
                    
                    
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
                alert(message: data.productTitle[sender.tag] as! String, title:"Already in Cart" )
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
    
    
    deinit {
        print("Remove NotificationCenter Deinit")
        NotificationCenter.default.removeObserver(self)
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
