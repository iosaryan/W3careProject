//
//  OrderVC.swift
//  W3Shop
//
//  Created by ios2 on 10/13/17.
//  Copyright © 2017 W3Care. All rights reserved.
//

import UIKit
import CoreData

class OrderVC: UIViewController {

    @IBOutlet var Orderbtn: UIButton!
    //  @IBOutlet var Table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
     var _: Timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(gotohomeVC), userInfo: nil, repeats: false)
        self.deleteAllData(entity: "Person")
    }

    @IBAction func Btnaction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func gotohomeVC() {
        
     self.navigationController?.popToRootViewController(animated: true)
        
        self.deleteAllData(entity: "Person")
        
    }
    
    //Core Data Container
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    func deleteAllData(entity: String)
    {
        
        let managedContext = getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
            
            let defaults = UserDefaults.standard
            defaults.set(0, forKey: "CartCount")
            defaults.synchronize()
            
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
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
