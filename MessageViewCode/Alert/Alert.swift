//
//  Alert.swift
//  Login ViewCode
//
//  Created by Jamerson Macedo on 25/10/24.
//

import Foundation
import UIKit
class Alert : NSObject{
    var controller : UIViewController
    
    init(controller: UIViewController){
        self.controller = controller
    }
    func getAlert(title: String, message: String, completion : (()->Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel){ _ in
            completion?()
        }
        alert.addAction(cancelAction)
        controller.present(alert, animated: true, completion: nil)
        

    }
}
