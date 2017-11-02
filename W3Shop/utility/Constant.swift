//
//  Constant.swift
//  testproject
//
//  Created by ios2 on 9/25/17.
//  Copyright © 2017 aryam-dev. All rights reserved.
//

import UIKit
import CoreData
import Alamofire



extension UIViewController {
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}


extension String {
    func trimmedText() -> String {
        // let trimmedString = value.trimmingCharacters(in: .whitespaces)
        return components(separatedBy: .whitespaces).joined()
    }
}
//Core Data Container
func getContext () -> NSManagedObjectContext {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.persistentContainer.viewContext
}


func UIColorFromRGB(rgb: Int, alpha: Float) -> UIColor {
    let red = CGFloat(Float(((rgb>>16) & 0xFF)) / 255.0)
    let green = CGFloat(Float(((rgb>>8) & 0xFF)) / 255.0)
    let blue = CGFloat(Float(((rgb>>0) & 0xFF)) / 255.0)
    let alpha = CGFloat(alpha)
    
    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
}


class Constant: NSObject {
    
   
        struct API {
            
                static let WelcomeAPI = "http://content.uplynk.com/player/assetinfo/ab19f0dc98dc4b7dbfcf88fa223a6c3b.json"
            }
            
            
    static let SCREEN_SIZE = UIScreen.main.fixedCoordinateSpace.bounds
    static let SCREEN_WIDTH = SCREEN_SIZE.width
    static let SCREEN_HEIGHT = SCREEN_SIZE.height
    

}
        
////////////////////****************************************************
////////////////////****************************************************
////////////////////****************************************************
////////////////////****************************************************
////////////////////****************************************************







    
    
    
   

