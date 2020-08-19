//
//  APIService.swift
//  demoApplication
//
//  Created by Macbook  on 8/19/20.
//  Copyright © 2020 mtvd. All rights reserved.
//

import UIKit
import Alamofire

//Path URL Request
enum ApiType {
    case api1
    case api2
    case api3
    case api4
    case api5
    
    func getPath() -> String {
        switch self {
        case .api1:
            return "/everything?q=bitcoin&from=2020-07-19&sortBy=publishedAt"
        case .api2:
            return "/top-headlines?country=us&category=business"
        case .api3:
            return "/everything?q=apple&from=2020-08-18&to=2020-08-18&sortBy=popularity"
        case .api4:
            return "/top-headlines?sources=techcrunch"
        case .api5:
            return "/everything?domains=wsj.com"
        }
    }
}

class APIService: NSObject {
//    http://newsapi.org/v2/everything?q=bitcoin&from=2020-07-19&sortBy=publishedAt&apiKey=API_KEY
//    http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=API_KEY
//    http://newsapi.org/v2/everything?q=apple&from=2020-08-18&to=2020-08-18&sortBy=popularity&apiKey=API_KEY
//    http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=API_KEY
//    http://newsapi.org/v2/everything?domains=wsj.com&apiKey=API_KEY
    static let apiKey = "4c78908e21b24d84bc56cb462d3e4424"
    static let shared = APIService()
    
    static func url1(string: String, key: String) -> URL {
        var stringURL = "http://newsapi.org/v2/everything?q={string}&from=2020-07-19&sortBy=publishedAt&apiKey={API_KEY}"
        let map = ["{string}" : string,
                   "{API_KEY}" : key] as [String : Any]
        
        for (key, value) in map {
            stringURL = stringURL.replacingOccurrences(of: key, with: "\(value)")
        }
        
        if let url = URL(string: stringURL) {
            return url
        }
        
        return URL.init(fileURLWithPath: "")
    }
    
    static func url2(type: ApiType, key: String) -> URL {
        var stringURL = "http://newsapi.org/v2{string}&apiKey={API_KEY}"
        let map = ["{string}" : type,
                   "{API_KEY}" : key] as [String : Any]
        
        for (key, value) in map {
            stringURL = stringURL.replacingOccurrences(of: key, with: "\(value)")
        }
        if let url = URL(string: stringURL) {
            return url
        }
        
        return URL.init(fileURLWithPath: "")
    }
    
    func getHeaderLogin() -> [String : String]? {
        return [
            "Content-Type" : "application/json"
        ]
    }
    
    func requestApiWith(url: URL,
                        parameters: [String : Any]? = nil,
                        complete: @escaping (String)->Void,
                        fail: @escaping (String)->() ) -> Request {
        let manager = Alamofire.Session.default
        let request = manager.request(url,
                                      method: .get,
                                      parameters: parameters,
                                      encoding: URLEncoding.default,
                                      headers: ["Content-Type" : "application/json"])
        request.responseString { (response) in
            complete(response.value ?? "")
        }
        
        return request
    }
}

