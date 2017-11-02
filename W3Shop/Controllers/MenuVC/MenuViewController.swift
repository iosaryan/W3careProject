//
//  AppDelegate.swift
//  W3Shop
//
//  Created by ios2 on 9/27/17.
//  Copyright © 2017 W3Care. All rights reserved.
//
import UIKit

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    /**
    *  Array to display menu options
    */
   // @IBOutlet var tblMenuOptions : UITableView!
    
    @IBOutlet weak var tblMenuOptions: UITableView!
    /**
    *  Transparent button to hide menu
    */
   
    @IBOutlet weak var btnCloseMenuOverlay: UIButton!
    
    /**
    *  Array containing menu options
    */
    var arrayMenuOptions = [Dictionary<String,String>]()
    
    /**
    *  Menu button which was tapped to display the menu
    */
    var btnMenu : UIButton!
    
    /**
    *  Delegate of the MenuVC
    */
    var delegate : SlideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblMenuOptions.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateArrayMenuOptions()
    }
    
    func updateArrayMenuOptions(){
        arrayMenuOptions.append(["title":"Watch", "icon":"w4"])
        arrayMenuOptions.append(["title":"Premium Watches", "icon":"w1"])
        arrayMenuOptions.append(["title":"new Watches", "icon":"w3"])
        arrayMenuOptions.append(["title":"maxima watches", "icon":"w5"])

        tblMenuOptions.reloadData()
    }
    
    @IBAction func onCloseMenuClick(_ button:UIButton!) {
        
                btnMenu.tag = 0
        
                if (self.delegate != nil) {
                    var index = Int32(button.tag)
                    if(button == self.btnCloseMenuOverlay){
                        index = -1
                    }
                    delegate?.slideMenuItemSelectedAtIndex(index)
                }
        
                UIView.animate(withDuration: 0.3, animations: { () -> Void in
                    self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
                    self.view.layoutIfNeeded()
                    self.view.backgroundColor = UIColor.clear
                    }, completion: { (finished) -> Void in
                        self.view.removeFromSuperview()
                        self.removeFromParentViewController()
                })
    }
  
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellMenu")!
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
        
        let lblTitle : UILabel = cell.contentView.viewWithTag(101) as! UILabel
        let imgIcon : UIImageView = cell.contentView.viewWithTag(100) as! UIImageView
        
        imgIcon.image = UIImage(named: arrayMenuOptions[indexPath.row]["icon"]!)
        lblTitle.text = arrayMenuOptions[indexPath.row]["title"]!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btn = UIButton(type: UIButtonType.custom)
        btn.tag = indexPath.row
        self.onCloseMenuClick(btn)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenuOptions.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
}
