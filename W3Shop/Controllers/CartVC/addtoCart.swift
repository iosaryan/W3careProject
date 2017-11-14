//
//  addtoCart.swift
//  W3Shop
//
//  Created by ios2 on 9/27/17.
//  Copyright © 2017 W3Care. All rights reserved.
//

import UIKit
import CoreData
import Stripe


class addtoCart: UIViewController , UITableViewDelegate ,UITableViewDataSource {
    
    @IBOutlet weak var Table: UITableView!
    @IBOutlet weak var AmountLbl: UILabel!
    @IBOutlet var TotalAmount: UIButton!
    
    var NameData   = [String!]()
    var PriceData  = [Float]()
    var ImageData  = [String!]()
    
    var localTotal:Float = 0.0
    fileprivate var rightCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Cart"

        
        self.getTranscriptions()
        
        Table.delegate = self
        Table.dataSource = self
        Table.separatorStyle = UITableViewCellSeparatorStyle.none
        self.Table.rowHeight = 104
        

        
        self.Table.tableFooterView = UIView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.CheckTableRowCount()
        Table.reloadData()
    }
    
  
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return(NameData.count)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CartCell

        cell.productName?.text = NameData[indexPath.item]

        let myStringToTwoDecimals = String(format:"%.2f", PriceData[indexPath.item])

        cell.Price?.text = myStringToTwoDecimals

        let dataDecoded : Data = Data(base64Encoded: ImageData[indexPath.item], options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        cell.IMG.image = decodedimage




        return(cell)
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            self.deleteProduct( Productname: NameData[indexPath.item])
            
            
            if(NameData.count == 0 ){
                self.CheckTableRowCount()
                TotalAmount.setTitle(String(format: "%@%.2f", " Total Cart Amount Rs: ", 0),for: .normal)
            }else{
                //*** subtract selected amount
                let totalamount =  localTotal
                let subamount = PriceData[indexPath.row] as Float
                let subTot = totalamount - subamount
                //print(subTot)
                TotalAmount.setTitle(String(format: "%@%.2f", " Total Cart Amount Rs: ", subTot),for: .normal)
                
                NameData.remove(at: indexPath.row)
                PriceData.remove(at: indexPath.row)
                ImageData.remove(at: indexPath.row)
                
                Table.deleteRows(at: [indexPath], with: .automatic)
                self.GetDeletedAmount()
            }
        }
    }
    
    
    
    
    
    @IBAction func TotalAmountBtn(_ sender: Any) {
        
        // alert(message: "Coming Soon", title: "this feature is not avaiable")
        let storyboard: UIStoryboard = UIStoryboard(name: "Cart", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "buyNowVC") as! buyNowVC
        // vc.productName = NameData[(sender as AnyObject).tag]
        vc.productPrice = String(format:"Rs %.2f", localTotal)
        self.show(vc, sender: self)
        
    }
    
    
    /*************************************************************************/
    /************************ Fatch Data From CoreData ***********************/
    
    func getTranscriptions () {
        
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        
        do {
            
            let searchResults = try getContext().fetch(fetchRequest)
            
            print ("num of results = \(searchResults.count)")
            
            for trans in searchResults as [NSManagedObject] {
                
                let amount = trans.value(forKey: "price") as! Float
                PriceData.append(amount)
                NameData.append((String(describing: trans.value(forKey: "productname")!)))
                ImageData.append((String(describing: trans.value(forKey: "image")!)))
            }
            
            self.GetTotalAmount()
            
            
            
        } catch {
            print("Error with request: \(error)")
        }
    }
    
    
    
    /*************************************************************************/
    /***************** Delete Selected Data From CoreData ********************/
    
    func deleteProduct (Productname:String) {
        
        let context = getContext()
        
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        
        do {
            //go get the results
            let array_users = try getContext().fetch(fetchRequest)
            
            
            for _ in array_users as [NSManagedObject] {
                
                let predicate = NSPredicate(format: "productname == %@", Productname)
                
                fetchRequest.predicate = predicate
                
                if let result = try? context.fetch(fetchRequest) {
                    for object in result {
                        context.delete(object)
                    }
                }
            }
            //****save the context
            
            do {
                try context.save()
                print("saved!")
                
                //**** update cart count
                rightCount  = (UserDefaults.standard.value(forKey: "CartCount")! as! Int)
                
                rightCount = rightCount - 1
                
                let defaults = UserDefaults.standard
                defaults.set(rightCount, forKey: "CartCount")
                defaults.synchronize()
                
                Table.reloadData()
                
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {}
            
        } catch {
            print("Error with request: \(error)")
        }
    }
    
    func GetTotalAmount()  {
        //********** Total amount
        for price in PriceData  {
            localTotal += Float(price)
        }
        TotalAmount.setTitle(String(format: "%@%.2f", " Total Cart Amount Rs: ", localTotal),for: .normal)
        TotalAmount.isHidden = false
    }
    
    func GetDeletedAmount()  {
        //********** Total amount
        
        localTotal = 0.0
        for price in PriceData  {
            localTotal += Float(price)
        }
        if localTotal < 1 {
            self.CheckTableRowCount()
        }
    }
    
    /*************************************************************************/
    /***************** Show Empty Label If There Is No Data ******************/
    /*************************************************************************/
    
    func CheckTableRowCount()   {
        if(NameData.count>0){
            
            //Table.separatorStyle = UITableViewCellSeparatorStyle.singleLine
            
        }else{
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: Constant.SCREEN_WIDTH , height: 21))
            label.center = CGPoint(x: Constant.SCREEN_WIDTH / 2.0, y: Constant.SCREEN_HEIGHT / 2.0 )
            label.textAlignment = .center
            label.text = "No Data is Currently Available !!"
            label.font = UIFont.systemFont(ofSize: 22)
            label.textColor = .orange
            label.backgroundColor = .clear
            label.translatesAutoresizingMaskIntoConstraints = true
            
            Table.backgroundView = label
            Table.separatorStyle = UITableViewCellSeparatorStyle.none;
            TotalAmount.isHidden = true
        }
    }
    
    
    //func didReceiveMemoryWarning() {
    //super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
    //   }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
