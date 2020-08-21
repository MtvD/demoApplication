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
    case apiCustom
    
    func getPath() -> String {
        switch self {
        case .api1:
            return "/everything?q=bitcoin"
        case .api2:
            return "/top-headlines?country=us"
        case .api3:
            return "/everything?q=apple"
        case .api4:
            return "/top-headlines?sources=techcrunch"
        case .api5:
            return "/everything?domains=wsj.com"
        case .apiCustom:
            return "/{firststring}?{key}={value}"
        }
    }
}

enum Environment : String {
    case dev = "http://newsapi.org/v2"
    
    func getEnviromentName() -> String {
        switch self {
        case .dev:
            return "Dev"
        }
    }
}

class APIService: NSObject {
    static let shared = APIService()
    fileprivate var enviroment : Environment = Environment.dev
    
    func url(type: ApiType) -> URL {
        return URL(string: self.enviroment.rawValue + type.getPath())!
    }
    
    func customeUrl(type: ApiType, firstString: String, key: String, value: String) -> URL {
        var stringURL = self.enviroment.rawValue + type.getPath()
        
        let map = ["{firststring}" : firstString,
                   "{key}" : key,
                   "value" : value] as [String : Any]
        
        for (key, value) in map {
            stringURL = stringURL.replacingOccurrences(of: key, with: "\(value)")
        }
        
        if let url = URL(string: stringURL) {
            return url
        }
        
        return URL.init(fileURLWithPath: "")
    }
    
    func requestApiWith(url: URL,
                        parameters: [String : Any]? = nil,
                        complete: @escaping (String)->Void,
                        fail: @escaping (String)->() ) -> Request {
        let manager = Alamofire.Session.default
        let request = manager.request(url,
                                      method: .get,
                                      parameters: parameters,
                                      encoding: URLEncoding.queryString,
                                      headers: [
                                          "User-Agent" : "PostmanRuntime/7.26.3",
                                          "Accept" : "*/*",
                                          "Accept-Encoding" : "gzip, deflate, br",
                                          "Connection" : "keep-alive"
                                      ])
        request.responseString { (response) in
            complete(response.value ?? "")
        }
        
        return request
    }
}

