//
//  MostPopularTableViewCell.swift
//  TLIKTestAssess
//
//  Created by ishteyaque on 15/11/18.
//  Copyright © 2018 ishteyaque. All rights reserved.
//

import UIKit

class MostPopularTableViewCell: UITableViewCell {
    var mostPopular:MostpopularModel!{
        didSet{
            popularTitleLabel.text=mostPopular.popularTitle
            authorLabel.text=mostPopular.authorTitle
            dateLabel.text=mostPopular.dateLabel
            if mostPopular.imageUrl != nil{
                self.mostPopularImageView.cacheImage(urlString: mostPopular.imageUrl)
            }
        }
    }
    @IBOutlet weak var mostPopularImageView: UIImageView!
    @IBOutlet weak var popularTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.mostPopularImageView.backgroundColor=UIColor.gray
        self.mostPopularImageView.applyCircular()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
    
}

class MostpopularModel{
    var popularTitle:String!
    var authorTitle:String!
    var dateLabel:String!
    var imageUrl:String!
    init(popularTitle:String,authorTitle:String,dateLabel:String,imageUrl:String) {
        self.popularTitle=popularTitle
        self.authorTitle=authorTitle
        self.dateLabel=dateLabel
        self.imageUrl=imageUrl
    }
}

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
