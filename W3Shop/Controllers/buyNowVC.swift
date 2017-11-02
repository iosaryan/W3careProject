//
//  buyNowVC.swift
//  W3Shop
//
//  Created by ios2 on 10/2/17.
//  Copyright © 2017 W3Care. All rights reserved.
//

import UIKit
import Stripe

class buyNowVC: UIViewController , STPPaymentCardTextFieldDelegate  {

    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    
    var paymentTextField: STPPaymentCardTextField! = nil
    
    var productName  = String()
    var productPrice = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Checkout"
    
        
        self.Name.text =  String(format: "Product Name: %@", productName );
        self.price.text = String(format: "Product Price: %@", productPrice );
        
        //print("Username" , UserDefaults.standard.string(forKey: "name")!)
        //print("PhoneNumber" , UserDefaults.standard.string(forKey: "phone")!)
        //print("Shipping Address", UserDefaults.standard.string(forKey: "address")!)
        
        paymentTextField = STPPaymentCardTextField(frame: CGRect(x: 15, y: view.frame.height/2-185, width: view.frame.width - 30, height: 44))
        paymentTextField.delegate = self
        view.addSubview(paymentTextField)
        
         self.hideKeyboard()
    }
    
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        submitButton.isEnabled = textField.isValid
    }
    
    @IBAction func submitCard(_ sender: AnyObject?) {
        // If you have your own form for getting credit card information, you can construct
        // your own STPCardParams from number, month, year, and CVV.
        let cardParams = paymentTextField.cardParams
        
        STPAPIClient.shared().createToken(withCard: cardParams) { token, error in
            guard let stripeToken = token else {
                NSLog("Error creating token: %@", error!.localizedDescription);
                return
            }
            
            // TODO: send the token to your server so it can create a charge
            let alert = UIAlertController(title: "Payment Successfull", message: "Token created: \(stripeToken)", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                //run your function here
                self.GoToNewShoot()
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func GoToNewShoot(){

        let storyboard = UIStoryboard(name: "Cart", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "OrderVC")
        vc.hidesBottomBarWhenPushed = true
        self.navigationController!.pushViewController(vc, animated: true)
        
    }
    
    // charge money from backend
    func postStripeToken(token: STPToken) {
        //Set up these params as your backend require
        let _: [String: NSObject] = ["stripeToken": token.tokenId as NSObject, "amount": 10 as NSObject]
        
        //TODO: Send params to your backend to process payment
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.paymentTextField.resignFirstResponder()
        return true
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
