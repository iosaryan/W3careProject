//
//  SessionManagerAPI.swift
//  W3Shop
//
//  Created by ios2 on 10/3/17.
//  Copyright © 2017 W3Care. All rights reserved.
//

import UIKit
import Alamofire




class SessionManagerAPI: NSObject {

    static let sharedInstance = SessionManagerAPI()
    private var manager: SessionManager
    
    override init() {
        self.manager = Alamofire.SessionManager.default
    }
        
    
    
//    internal typealias RequestCompletion = (Int?, Error?) -> ()?
//    private var completionBlock: RequestCompletion!
//    var afManager : SessionManager!
//
//
//    func makeAlamofireRequest(url :String){
//
//        let configuration = URLSessionConfiguration.default
//
//        afManager = Alamofire.SessionManager(configuration: configuration)
//        afManager.request(url, method: .post).validate().responseJSON {
//            response in
//            switch (response.result) {
//            case .success:
//                print("data - > \n    \(String(describing: response.data?.debugDescription)) \n")
//                print("response - >\n    \(String(describing: response.response?.debugDescription)) \n")
//                let statusCode = 0
//                if let unwrappedResponse = response.response {
//                    _ = unwrappedResponse.statusCode
//                }
//                self.completionBlock(statusCode, nil)
//
//                break
//            case .failure(let error):
//                print("error - > \n    \(error.localizedDescription) \n")
//                let statusCode = response.response?.statusCode
//                self.completionBlock?(statusCode, error)
//                break
//            }
//        }
//    }
    
    
    
}
