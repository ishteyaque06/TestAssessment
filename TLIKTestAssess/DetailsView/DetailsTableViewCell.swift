//
//  DetailsTableViewCell.swift
//  TLIKTestAssess
//
//  Created by ishteyaque on 16/11/18.
//  Copyright © 2018 ishteyaque. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    var mostPopular:MostpopularModel!{
        didSet{
            popularTitle.text=mostPopular.popularTitle
            authorLabel.text=mostPopular.authorTitle
            detailsLabel.text=mostPopular.details
            if mostPopular.imageUrl != nil && mostPopular.imageUrl != ""{
                self.popularImageView.cacheImage(urlString: mostPopular.imageUrl)
            }
        }
    }
    @IBOutlet weak var popularTitle: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var popularImageView: UIImageView!
   
    
}
