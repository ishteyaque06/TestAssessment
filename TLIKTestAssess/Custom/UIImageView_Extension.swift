//
//  UIImageView_Extension.swift
//  TLIKTestAssess
//
//  Created by ishteyaque on 16/11/18.
//  Copyright © 2018 ishteyaque. All rights reserved.
//

import Foundation
import UIKit
let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView{
    func applyCircular(){
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    func cacheImage(urlString: String){
        let url = URL(string: urlString.encodedUrl())
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        URLSession.shared.dataTask(with: url!) {
            data, response, error in
            if data != nil {
                DispatchQueue.main.async {
                    if let imageToCache = UIImage(data: data!){
                        imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                        self.image = imageToCache
                    }
                }
            }
            }.resume()
    }
    
}


extension String{
    func encodedUrl () -> String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! //.urlHostAllowed
    }
    
}
