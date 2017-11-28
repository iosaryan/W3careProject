//
//  FilterVC.swift
//  W3Shop
//
//  Created by ios2 on 11/6/17.
//  Copyright © 2017 W3Care. All rights reserved.
//

import UIKit
import ZMSwiftRangeSlider

class FilterVC: UIViewController   {
    
    var data = itemList()
    
    @IBOutlet weak var silder: RangeSlider!
    @IBOutlet weak var colorPickerView: UIView!
    
    @IBOutlet weak var color_lbl: UILabel!
    @IBOutlet weak var filter_Aply: UIButton!
    @IBOutlet weak var result_count_lbl: UILabel!
    
    var colorStr = String()
 // var priceResult =  Array<Any>()
  
    var rangePrice = Array<Int> ()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Filter"
        
        
        
        // **** Tap Gesture
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(colorPickerView_Taped(sender:)))
        colorPickerView.isUserInteractionEnabled = true
        colorPickerView.addGestureRecognizer(tapGestureRecognizer)
       
        
        silder.setValueChangedCallback { (minValue, maxValue) in
            print(" min value:\(minValue)")
            print(" max value:\(maxValue)")
            
            //let array = [99, 42, 34, 19, 29, 167, 30, 49, 39, 75, 175, 270, 540]
            let array = [99, 42, 34, 19, 29, 167, 30, 49, 39, 75, 175, 270, 540,
                         5000,2450, 6000, 1590, 1455, 1799, 1921, 200]
         
            let newArray = array.filter{$0 > minValue && $0 < maxValue}
           

            DispatchQueue.main.async {
                
                //var priceResult =  Array<Any>()
                // priceResult.append(newArray)
               
                self.rangePrice =  newArray
                
                
                let productCount = String(newArray.count)
                self.result_count_lbl.text = String(format: "%@ Result Found ",productCount)
                print(newArray.count)
            }
        }
            
        
        silder.setMinValueDisplayTextGetter { (minValue) -> String? in
            return "$\(minValue)"
        }
        silder.setMaxValueDisplayTextGetter { (maxValue) -> String? in
            return "$\(maxValue)"
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //*** Register to receive notification in your class
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.pickColor(_:)), name: NSNotification.Name(rawValue: "product_Color"), object: nil)
        
        
    }
    
    

    @objc func colorPickerView_Taped(sender: UITapGestureRecognizer)
    {
        let VC =  colorPickerVC()
        self.navigationController?.present(VC, animated: true, completion: nil)
    }
    
    
    // handle notification
    @objc func pickColor(_ notification: NSNotification) {
        
        if let color = notification.userInfo?["color"] as? String {
            
           colorStr = color
           color_lbl.text = String(format: "%@ Color ",color)

        }
    }
    
  
    
    
  
    

    @IBAction func silder_Valuechange(_ sender: Any) {
        
    }
    
    
    
    @IBAction func Filter(_ sender: Any) {
        
        if (color_lbl.text?.characters.count)!>6 || (rangePrice.count)>0 {
           
            let VC = filterResult()
            VC.color = colorStr
            VC.priceFilter =  rangePrice
            
            self.navigationController?.pushViewController(VC, animated: true)
            
        }else{
            alert(message: "Please Select Color or Range")
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
