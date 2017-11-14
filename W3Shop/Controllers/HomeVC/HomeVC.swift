//
//  HomeVC.swift
//  W3Shop
//
//  Created by ios2 on 9/27/17.
//  Copyright © 2017 W3Care. All rights reserved.
//

import UIKit
import CoreData
import AudioToolbox

class HomeVC: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout ,UITabBarControllerDelegate  , UIScrollViewDelegate {
    
    
    let data = itemList()
 
    let reuseIdentifier = "HomeCell"
    let BannerIdentifier = "BannerCell"
    let reuseIdentifierfor_Header = "CollectionHeaderView"
    let reuseIdentifierfor_2_Header = "HeaderView2"
    
    let trans = [] as Array
    var label = UILabel()
    
    fileprivate var rightCount = 0
   
   // var searchActive : Bool = false
    //var filtered:[String] = []
    var timer = Timer()
    
    var headerView =   CollectionHeaderView()
    
    
    @IBOutlet weak var CollectionView: UICollectionView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Product"
        
        
        //i am using xibs:
        self.CollectionView!.register(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.CollectionView!.register(UINib(nibName: "bannerCell", bundle: nil), forCellWithReuseIdentifier: BannerIdentifier)
        
        //*** register header class
        self.CollectionView!.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseIdentifierfor_Header)
        self.CollectionView!.register(UINib(nibName: "Header2_ReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: reuseIdentifierfor_2_Header)
        /* Go to homevc xib annd on header if you want to you headerView in collectionView  */
        
        
        
        /* Setup delegates */
        self.CollectionView.delegate = self
        self.CollectionView.dataSource = self
        self.CollectionView.allowsSelection = true
        self.CollectionView.isUserInteractionEnabled = true
        
        addSlideMenuButton()
        scheduledTimerWithTimeInterval()
        self.hideKeyboard()
        
        // Reload the table
        CollectionView.reloadData()
        
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        badgeBarButtomItem()
    }
    
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 2 seconds
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.moveToNextSlider(sender:)), userInfo: nil, repeats: true)
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
        
        //*** add another button item
        let image1 = UIImage(imageLiteralResourceName: "ic_account_outline")
        let rightButton1 = UIButton(frame: CGRect(x: 0, y: 0, width: image1.size.width, height: image1.size.height))
        rightButton1.setBackgroundImage(image1, for: .normal)
        rightButton1.addTarget(self, action: #selector(GotoUserDetails), for: .touchUpInside)
        
        //*** add another button item
        let image2 = UIImage(imageLiteralResourceName: "search")
        let rightButton2 = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        rightButton2.setBackgroundImage(image2, for: .normal)
        rightButton2.addTarget(self, action: #selector(Gotosearch), for: .touchUpInside)
        
        let rightBarButtomItem  = UIBarButtonItem(customView: rightButton)
        let rightBarButtomItem1 = UIBarButtonItem(customView: rightButton1)
        let rightBarButtomItem2 = UIBarButtonItem(customView: rightButton2)
        
        //*** Bar button item
        let barButton_array: [UIBarButtonItem] = [rightBarButtomItem, rightBarButtomItem1 ,rightBarButtomItem2 ]
        navigationItem.setRightBarButtonItems(barButton_array, animated: false)
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            
            
            
            if indexPath.section == 0 {
                print("Banners")
                
                headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: reuseIdentifierfor_Header,
                                                                             for: indexPath) as! CollectionHeaderView
                
                let ArrCount = 4
                var imageViewObject = UIImageView()
                var xvalue = Int()
                
                for i in 0 ..< ArrCount {
                    
                    if(Constant.SCREEN_WIDTH == 320){
                         xvalue = 292
                    }else if(Constant.SCREEN_WIDTH == 375) {
                         xvalue = 347
                    }else{
                         xvalue = 386
                    }
                    
                    imageViewObject = UIImageView(frame:CGRect(x: xvalue * i, y: 0, width: Int(headerView.ScrollView.frame.size.width), height: 160))
                    imageViewObject.clipsToBounds = true
                     imageViewObject.contentMode = UIViewContentMode.scaleToFill
                    imageViewObject.image = UIImage(named: data.sliderImage[i])
                    headerView.ScrollView.addSubview(imageViewObject)
                    
                    // **** Tap Gesture
                    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
                    imageViewObject.isUserInteractionEnabled = true
                    imageViewObject.addGestureRecognizer(tapGestureRecognizer)
                    
                    
                }
                
                headerView.ScrollView.contentSize = CGSize(width:  headerView.ScrollView.frame.size.width * 4, height: 160)
                headerView.slideControl.numberOfPages = ArrCount
                
                //scrollViewDidEndDecelerating( headerView.ScrollView)
                headerView.slideControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
                
                // *** define actions
                 headerView.mens_btn.addTarget(self, action: #selector(MensClick), for: UIControlEvents.touchUpInside)
                 headerView.women_Btn.addTarget(self, action: #selector(WomenClick), for: UIControlEvents.touchUpInside)
                 headerView.kid_btn.addTarget(self, action: #selector(KidsClick), for: UIControlEvents.touchUpInside)
                 headerView.offier_btn.addTarget(self, action: #selector(OthersClick), for: UIControlEvents.touchUpInside)
               
                
                
                return headerView
                
            }else{
                let headerView2 = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                  withReuseIdentifier: reuseIdentifierfor_2_Header,
                                                                                  for: indexPath) as! Header2_ReusableView
                return headerView2
            }
            
        default:break
            
        }
        return UICollectionReusableView()
    }

    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(headerView.slideControl.currentPage) * headerView.ScrollView.frame.size.width
        headerView.ScrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }
    
    
     // *** Slider Method with Timer
    @objc func moveToNextSlider(sender: AnyObject) -> () {
        
            let pageWidth:CGFloat = self.headerView.ScrollView.frame.size.width
            let maxWidth:CGFloat = pageWidth * 4
            let contentOffset:CGFloat = self.headerView.ScrollView.contentOffset.x

            var slideToX = contentOffset + pageWidth

            if  contentOffset + pageWidth == maxWidth{
                slideToX = 0
            }
            let page = Int(floor(( self.headerView.ScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
            //print("page = \(page)")
            self.headerView.slideControl.currentPage = page
            self.headerView.ScrollView!.scrollRectToVisible(CGRect(x:slideToX , y: 0, width:pageWidth, height:self.headerView.ScrollView.frame.size.height), animated: true)
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageWidth =  headerView.ScrollView.frame.size.width
        let page = Int(floor(( headerView.ScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        //print("page = \(page)")
        headerView.slideControl.currentPage = page
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let pageWidth =  headerView.ScrollView.frame.size.width
        let page = Int(floor(( headerView.ScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        //print("page = \(page)")
        headerView.slideControl.currentPage = page
    }
    
    // *** Action of MENS , WOMEN , KIDS , OTHERS
    @objc func MensClick(sender: AnyObject) -> () {
        
        let ViewController = ProductDetails()
        ViewController.productTitle  =  data.productTitle[sender.tag] as! String
        ViewController.ProductPrice =  "Rs" + data.productSalePrice[sender.tag]
        ViewController.productSalePrice =  data.productSalePrice[sender.tag]
        ViewController.ProductImage  = UIImage(named: data.productImage[sender.tag]!)
        ViewController.productDescription = data.productDescription[sender.tag]
        ViewController.productDetail_Description = data.productDetail_Description[sender.tag]
        ViewController.productCategory =  data.productCategory[sender.tag]
        
        
        self.navigationController?.pushViewController(ViewController, animated: true)
    }
    
    @objc func WomenClick(sender: AnyObject) -> () {
        let ViewController = ProductDetails()
        ViewController.productTitle  =  data.productTitle[sender.tag] as! String
        ViewController.ProductPrice =  "Rs" + data.productSalePrice[sender.tag]
        ViewController.productSalePrice =  data.productSalePrice[sender.tag]
        ViewController.ProductImage  = UIImage(named: data.productImage[sender.tag]!)
        ViewController.productDescription = data.productDescription[sender.tag]
        ViewController.productDetail_Description = data.productDetail_Description[sender.tag]
        ViewController.productCategory =  data.productCategory[sender.tag]
        
        
        self.navigationController?.pushViewController(ViewController, animated: true)
    }
    
    @objc func KidsClick(sender: AnyObject) -> () {
        let ViewController = ProductDetails()
        ViewController.productTitle  =  data.productTitle[sender.tag] as! String
        ViewController.ProductPrice =  "Rs" + data.productSalePrice[sender.tag]
        ViewController.productSalePrice =  data.productSalePrice[sender.tag]
        ViewController.ProductImage  = UIImage(named: data.productImage[sender.tag]!)
        ViewController.productDescription = data.productDescription[sender.tag]
        ViewController.productDetail_Description = data.productDetail_Description[sender.tag]
        ViewController.productCategory =  data.productCategory[sender.tag]
        
        
        self.navigationController?.pushViewController(ViewController, animated: true)
    }
    
    @objc func OthersClick(sender: AnyObject) -> () {
        let ViewController = ProductDetails()
        ViewController.productTitle  =  data.productTitle[sender.tag] as! String
        ViewController.ProductPrice =  "Rs" + data.productSalePrice[sender.tag]
        ViewController.productSalePrice =  data.productSalePrice[sender.tag]
        ViewController.ProductImage  = UIImage(named: data.productImage[sender.tag]!)
        ViewController.productDescription = data.productDescription[sender.tag]
        ViewController.productDetail_Description = data.productDetail_Description[sender.tag]
        ViewController.productCategory =  data.productCategory[sender.tag]
        
        
        self.navigationController?.pushViewController(ViewController, animated: true)
    }
    
    
    // MARK: - CollectionView Header Height
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize{
        
        if section == 0{
            return CGSize(width: Constant.SCREEN_WIDTH , height: 320)
        }else{
            return CGSize(width: Constant.SCREEN_WIDTH , height: 70)
        }
        
        
    }
    
    
    
    // MARK: - CollectionView Delegate & DataSourse Method
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return data.bannerImage.count
        }else{
            
            return data.productTitle.count
        }
    }
    
    // MARK: - UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: Constant.SCREEN_WIDTH , height: 250)
        }else{
            return CGSize(width: self.view.frame.size.width / 2.0-13, height: 208)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if indexPath.section == 0 {
            
            let bannercell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerIdentifier, for: indexPath) as! bannerCell
            
            bannercell.bannerImage.image = UIImage(named: data.bannerImage[indexPath.row]!)
            
            // **** Tap Gesture
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(bannercell_Taped(sender:)))
            bannercell.isUserInteractionEnabled = true
            
            bannercell.addGestureRecognizer(tapGestureRecognizer)
            
            
            return bannercell
            
        }else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HomeCell
            
            
            cell.Productname.text = data.productTitle[indexPath.item] as? String
            cell.IMG.image        = UIImage(named: data.productImage[indexPath.row]!)
            cell.colorText.text   = data.productDescription[indexPath.row]
            cell.priceText.text   = "Rs" + data.productSalePrice[indexPath.row]
            
            cell.AddtoCartBtn.tag = indexPath.row
            
            cell.screenBtn.tag = indexPath.row
            cell.AddtoCartBtn.addTarget(self, action: #selector(AddtoCartBtn), for: UIControlEvents.touchUpInside)
            cell.screenBtn.addTarget(self , action: #selector (screenBtnPress) , for: UIControlEvents.touchUpInside)
            
            return cell
            
        }
        
       
        
    }

   
    // MARK: - UICollectionViewDelegate protocol
    func collectionView(_collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        
    }
    
  
    

    
    
    
/*******************************************************************************/
/*********************   Define UIButton Action  *******************************/
/*******************************************************************************/
    
    @objc func screenBtnPress(_ sender : UIButton){
        //*** action- 'click'on today deal
        let ViewController = ProductDetails()
        ViewController.productTitle  =  data.productTitle[sender.tag] as! String
        ViewController.ProductPrice =  "Rs" + data.productSalePrice[sender.tag]
        ViewController.productSalePrice =  data.productSalePrice[sender.tag]
        ViewController.ProductImage  = UIImage(named: data.productImage[sender.tag]!)
        ViewController.productDescription = data.productDescription[sender.tag]
        ViewController.productDetail_Description = data.productDetail_Description[sender.tag]
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
    
    @objc func GotoUserDetails(_ sender: UIButton){
        
        let VC = UserDetails() //UserDetails(nibName:"UserDetails",bundle: nil)
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    
    
    @objc func Gotosearch(_ sender : UIButton){
        
        let ViewController = SearchVC()
        self.navigationController?.pushViewController(ViewController, animated: true)
    }
    
    
    @objc func categorymenu(_ sender : UIButton){
        // let ViewController = SideMenu()
        // self.navigationController?.pushViewController(ViewController, animated: true)
    }
    
    
    
     //*** action- 'click'on single Banners
    @objc func bannercell_Taped(sender: UITapGestureRecognizer)
    {
        if let cell = sender.view as? bannerCell,
           let indexPath =  self.CollectionView.indexPath(for: cell) {
            print(indexPath.row)
            //
            let ViewController = ProductDetails()
            ViewController.productTitle  =  data.productTitle[indexPath.row] as! String
            ViewController.ProductPrice = "Rs" + data.productSalePrice[indexPath.row]
            ViewController.productSalePrice =  data.productSalePrice[indexPath.row]
            ViewController.ProductImage  = UIImage(named: data.productImage[indexPath.row]!)
            ViewController.productDescription = data.productDescription[indexPath.row]
            ViewController.productDetail_Description = data.productDetail_Description[indexPath.row]
            ViewController.productCategory =  data.productCategory[indexPath.row]
            self.navigationController?.pushViewController(ViewController, animated: true)
            
        }
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
