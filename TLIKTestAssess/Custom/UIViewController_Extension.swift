//
//  UIViewController_Extension.swift
//  TLIKTestAssess
//
//  Created by ishteyaque on 16/11/18.
//  Copyright © 2018 ishteyaque. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func showAlert(title:String? = "" ,message:String?){
        let alert=UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler:nil))
        self.present(alert, animated: true, completion: nil)
    }
}
