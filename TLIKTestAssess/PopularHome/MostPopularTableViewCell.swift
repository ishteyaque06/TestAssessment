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
            if mostPopular.imageUrl != nil && mostPopular.imageUrl != ""{
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
        self.mostPopularImageView.applyCircular()
    }
    
}




