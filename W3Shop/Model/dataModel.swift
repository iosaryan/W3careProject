//
//  dataModel.swift
//  testproject
//
//  Created by ios2 on 9/26/17.
//  Copyright © 2017 aryam-dev. All rights reserved.
//

import UIKit


class dataModel: NSObject  {
    
//     NSCoding
//    func encode(with aCoder: NSCoder) {
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//    }
    
    let firstname: String
    let lastname: String
    let age: Int
    
    init(firstname: String, lastname: String) {
        self.firstname = firstname
        self.lastname = lastname
        self.age = 10
    }
    
}
//create extension of model
extension dataModel {
    func age(age: Int) -> dataModel {
        return dataModel(firstname :firstname, lastname :lastname )
    }
}
