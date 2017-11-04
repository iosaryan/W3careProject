//
//  SearchVC.swift
//  W3Shop
//
//  Created by ios2 on 11/4/17.
//  Copyright © 2017 W3Care. All rights reserved.
//

import UIKit
import CoreData
import AudioToolbox

class SearchVC: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UISearchControllerDelegate , UISearchBarDelegate{
    
    
    
    @IBOutlet weak var search_CollectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    let data = itemList()
    let reuseIdentifier = "HomeCell"
    
    let trans = [] as Array
    fileprivate var rightCount = 0
    var label = UILabel()
    
    var searchActive : Bool = false
    var filtered:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.title = "Search"
        
        //i am using xibs:
        self.search_CollectionView!.register(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        
        /* Setup delegates */
        self.search_CollectionView.delegate = self
        self.search_CollectionView.dataSource = self
        self.search_CollectionView.allowsSelection = true
        self.search_CollectionView.isUserInteractionEnabled = true
        searchBar.delegate = self
        self.search_CollectionView.reloadData()
        
        badgeBarButtomItem()
        self.hideKeyboard()
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
        }
        return data.productTitle.count
        
    }
    
    // MARK: - UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: self.view.frame.size.width / 2.0-13, height: 208)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCell
        
        if(searchActive){
            
            //  cell.Productname.text = filtered[indexPath.item]
        } else {
            cell.Productname.text = data.productTitle[indexPath.item] as? String
            cell.IMG.image        = UIImage(named: data.productImage[indexPath.row]!)
            //cell.addtocart_img.image = UIImage(named: "addtoCart")
            cell.colorText.text   = data.productDescription[indexPath.row]
            cell.priceText.text   = "Rs" + data.productSalePrice[indexPath.row]
            
        }
        
        cell.AddtoCartBtn.tag = indexPath.row
        //cell.buynow.tag = indexPath.row
        cell.screenBtn.tag = indexPath.row
        cell.AddtoCartBtn.addTarget(self, action: #selector(AddtoCartBtn), for: UIControlEvents.touchUpInside)
        // cell.buynow.addTarget(self, action: #selector(BuynowBtn), for: UIControlEvents.touchUpInside)
        cell.screenBtn.addTarget(self , action: #selector (screenBtnPress) , for: UIControlEvents.touchUpInside)
        
        return cell
        
        
        
        
        
    }
    
    
    // MARK: - UICollectionViewDelegate protocol
    func collectionView(_collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
    
    
    
    
    
    
    
    /*********************   Define Searching Method  *******************************/
    
    //*** called when search dismiss
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        self.hideKeyboard()
    }
    
    //*** called when search button is clicked
    func searchBarSearchButtonClicked(_searchBar: UISearchBar) {
        searchActive = false;
        self.view.endEditing(true)
        self.search_CollectionView.reloadData()
    }
    
    // *** called when text change
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered.removeAll(keepingCapacity: false)
        
        searchActive = true;
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchBar.text!)
        let array = (data.productTitle as NSArray).filtered(using: searchPredicate)
        filtered = array as! [String]
        
        // ** text Field Emply Check
        if  searchBar.text! .isEmpty{
            searchActive = false;
            self.hideKeyboard()
        }
        self.search_CollectionView.reloadData()
    }
    
    
    /*******************************************************************************/
    /*********************   Define UIButton Action  *******************************/
    /*******************************************************************************/
    
    @objc func screenBtnPress(_ sender : UIButton){
        
        let ViewController = ProductDetails()
        ViewController.productTitle  =  data.productTitle[sender.tag] as! String
        ViewController.ProductPrice = "Rs" + data.productSalePrice[sender.tag]
        ViewController.productSalePrice = "Rs" + data.productSalePrice[sender.tag]
        ViewController.ProductImage  = UIImage(named: data.productImage[sender.tag]!)
        ViewController.productDescription = data.productDescription[sender.tag]
        ViewController.productCategory =  data.productCategory[sender.tag]
        
        
        self.navigationController?.pushViewController(ViewController, animated: true)
    }
    
    
    @objc func AddtoCartBtn(_ sender : UIButton){
        //*** check context already exist
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        let predicate = NSPredicate(format: "productname == %@", data.productTitle[sender.tag] as!  CVarArg)
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
                person.setValue(data.productTitle[sender.tag], forKey: "productname")
                person.setValue(Float(data.productSalePrice[sender.tag]), forKey: "price")
                
                let UIimage = UIImage(named: data.productImage[sender.tag]!)
                let imageData: NSData = UIImagePNGRepresentation(UIimage!)! as NSData
                
                let ImageStr = imageData.base64EncodedString(options: .lineLength64Characters)
                person.setValue(ImageStr, forKey: "image")
                
                //****** save the object
                do {
                    try context.save()
                    print("saved!")
                    alert(message: data.productTitle[sender.tag] as! String, title:"Successfully added to cart" )
                    
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
