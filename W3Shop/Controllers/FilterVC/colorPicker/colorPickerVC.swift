//
//  colorPickerVC.swift
//  W3Shop
//
//  Created by ios2 on 11/6/17.
//  Copyright © 2017 W3Care. All rights reserved.
//

import UIKit

class colorPickerVC: UIViewController ,  UITableViewDataSource ,UITableViewDelegate {

    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var color_Table: UITableView!
    
     let data = itemList()
     var color   = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        color_Table.register(UINib(nibName: "colorCell", bundle: nil), forCellReuseIdentifier: "colorCell")
        color_Table.delegate = self
        color_Table.dataSource = self
        color_Table.reloadData()
        
        //Detault Background clear
        color_Table.backgroundColor = UIColor.clear
        color_Table.tableFooterView = UIView()
        
        
        doneBtn.isHidden = true
    }

    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.productDescription.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell") as! colorCell
        // Configure the cell...
        cell.colorName.text   = data.productDescription[indexPath.row]
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
            cell.accessoryType = .none
            
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            doneBtn.isHidden = false
            
            color = String(data.productDescription[indexPath.row])
            
        }
    }
    
    
    @IBAction func done(_ sender: Any) {
        
        let Dict:[String: String] = ["color": color]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "product_Color"), object: nil, userInfo: Dict)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func close(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
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
