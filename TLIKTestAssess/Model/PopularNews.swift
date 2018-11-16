//
//  PopularNews.swift
//  TLIKTestAssess
//
//  Created by ishteyaque on 16/11/18.
//  Copyright © 2018 ishteyaque. All rights reserved.
//

import Foundation

class MostpopularModel{
    var popularTitle:String!
    var authorTitle:String!
    var dateLabel:String!
    var imageUrl:String!
    var details:String!
    var id:Int!
    init(popularTitle:String,authorTitle:String,dateLabel:String,imageUrl:String,details:String) {
        self.popularTitle=popularTitle
        self.authorTitle=authorTitle
        self.dateLabel=dateLabel
        self.imageUrl=imageUrl
        self.details=details
    }
    init?(jsonData:[String:Any]) {
        guard
            let title = jsonData["title"] as? String,
            let content = jsonData["abstract"] as? String,
            let author = jsonData["byline"] as? String,
            let id = jsonData["id"] as? Int,
            let medias = jsonData["media"] as? [[String: Any]],
            let date = jsonData["published_date"] as? String else {
                return nil
        }
        var newsImageURL=""
        for medi in medias{
            if let mediaData=medi["media-metadata"]as?[[String:Any]]{
                for item in mediaData{
                    if let thumbnail = item["format"] as? String,
                        thumbnail == "Standard Thumbnail",
                        let urlSring = item["url"] as? String{
                        newsImageURL=urlSring
                        break
                    }
                }
            }
        }
        self.popularTitle=title
        self.details=content
        self.authorTitle=author
        self.imageUrl=newsImageURL
        self.id=id
        self.dateLabel=date
    }
}
