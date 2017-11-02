//
//  UserDetails.swift
//  
//
//  Created by ios2 on 10/3/17.
//

import UIKit
import CoreData

class UserDetails: UIViewController , UIScrollViewDelegate , UITextFieldDelegate ,UITextViewDelegate {

    @IBOutlet var userName: UITextField!
    @IBOutlet var phoneNumber: UITextField!
    @IBOutlet var shippingAddress: UITextView!
    @IBOutlet var SaveBtn: UIButton!
    @IBOutlet var ScrollView: UIScrollView!
    @IBOutlet var BGView: UIView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "User Detail"
        
       self.shippingAddress.delegate = self
        /*
         self.BGView.frame = CGRect (x:0 , y:0 , width:Constant.SCREEN_WIDTH , height:BGView.frame.height)
         self.ScrollView.contentSize = CGSize(width: BGView.frame.size.width , height: BGView.frame.height)
         ScrollView.addSubview(BGView)
         */
       self.BGView.frame = CGRect (x:0 , y:0 , width:Constant.SCREEN_WIDTH , height:BGView.frame.height)
       self.ScrollView.contentSize = CGSize(width: self.BGView.frame.size.width  , height: self.view.frame.size.height)
       self.ScrollView.addSubview(BGView)
        
        self.hideKeyboard()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func Save(_ sender: Any) {
        
        UserDefaults.standard.set(userName.text, forKey: "name")
        UserDefaults.standard.set(phoneNumber.text, forKey: "phone")
        UserDefaults.standard.set(shippingAddress.text, forKey: "address")
        
        /*
         UserDefaults.standard.bool(forKey: "Key")
         UserDefaults.standard.integer(forKey: "Key")
         UserDefaults.standard.string(forKey: "Key")
         */
        
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
