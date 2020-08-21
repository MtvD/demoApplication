//
//  ResObject.swift
//  demoApplication
//
//  Created by Macbook  on 8/21/20.
//  Copyright © 2020 mtvd. All rights reserved.
//

import Foundation

class ResObject: NSObject {
    var status : String?
    var totalResults: Int?
    
    init?(json : [String :  Any]?){
        super.init()
        guard let json  = json else { return }
        status = json["status"] as? String
        totalResults = json["totalResults"] as? Int
    }
}


class ArticleRes : ResObject {
    var articles: [Article] = []
    
    override init?(json: [String : Any]?) {
        super.init(json: json)
        guard let json  = json else { return }
        
        if let articles = json["articles"] as? [[String: Any]] {
            self.articles.removeAll()
            for index in 0..<articles.count{
                let dict = articles[index]
                if let item = Article.init(json: dict) {
                    self.articles.append(item)
                }
            }
        }
    }
    
}
