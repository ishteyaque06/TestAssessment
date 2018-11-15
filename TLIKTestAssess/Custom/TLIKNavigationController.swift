//
//  TLIKNavigationController.swift
//  TLIKTestAssess
//
//  Created by ishteyaque on 15/11/18.
//  Copyright © 2018 ishteyaque. All rights reserved.
//

import UIKit

class TLIKNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = UIColor.init(red: 69/255, green: 240/255, blue: 211/255, alpha: 1)
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue):UIColor.white,NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)]
    }
   

}
