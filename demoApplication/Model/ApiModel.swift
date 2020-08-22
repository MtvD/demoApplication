//
//  ApiModel.swift
//  demoApplication
//
//  Created by Macbook  on 8/21/20.
//  Copyright © 2020 mtvd. All rights reserved.
//

import Foundation

class ApiModel : BaseItem {
    var status : String?
    var totalResults : Int?
    var articles : [Article] = []
    
    override init?(json: [String : Any]?) {
        super.init(json: json)
        guard let json  = json else { return }
        
        status = json["status"] as? String ?? ""
        totalResults = json["totalResults"] as? Int ?? -1
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
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Article: BaseItem {
    var title: String?
    var author: String?
    var titleApi: String?
    var descriptionApi: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    
    override init?(json: [String : Any]?) {
        super.init(json: json)
        guard let json  = json else { return }
        
        title = json["title"] as? String ?? ""
        author = json["author"] as? String ?? ""
        titleApi = json["title"] as? String ?? ""
        descriptionApi = json["description"] as? String ?? ""
        url = json["url"] as? String ?? ""
        urlToImage = json["urlToImage"] as? String ?? ""
        publishedAt = json["publishedAt"] as? String ?? ""
        content = json["content"] as? String ?? ""
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
