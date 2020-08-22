//
//  FirstApiViewModel.swift
//  demoApplication
//
//  Created by Macbook  on 8/21/20.
//  Copyright © 2020 mtvd. All rights reserved.
//

import Foundation

protocol ViewModelDelegate: class {
    func submitSuccess(response: Any)
    func submitFail(response: String)
}

class FirstApiViewModel {
    weak var delegate: ViewModelDelegate?
    
    func getList(type: ApiType) {
        let params : [String : Any] = [
            "from" : "2020-07-\(getCurrentDate())",
            "sortBy" : "publishedAt",
            "apiKey" : "4c78908e21b24d84bc56cb462d3e4424"
        ]
        
        _ = APIService.shared.requestApiWith(url: APIService.shared.url(type: .api1), parameters: params, complete: { (res) in
            let response = ApiModel.init(json: res.convertToDictionary())
            self.delegate?.submitSuccess(response: response ?? "Error")
        }) { (er) in
            self.delegate?.submitFail(response: er)
        }
    }
    
    func getTopHeadLineList(type: ApiType) {
        let params : [String : Any] = [
            "category" : "business",
            "apiKey" : "4c78908e21b24d84bc56cb462d3e4424"
        ]
        
        _ = APIService.shared.requestApiWith(url: APIService.shared.url(type: .apiTopHeadLine), parameters: params, complete: { (res) in
            let response = ApiModel.init(json: res.convertToDictionary())
            self.delegate?.submitSuccess(response: response ?? "Error")
        }) { (er) in
            self.delegate?.submitFail(response: er)
        }
    }
    
    func getCustomLink(str: String) {
        let params : [String : Any] = [
            "from" : "2020-07-\(getCurrentDate())",
            "sortBy" : "publishedAt",
            "apiKey" : "4c78908e21b24d84bc56cb462d3e4424"
        ]
        
        let url = APIService.shared.customeUrl(firstString: str)
        
        _ = APIService.shared.requestApiWith(url: url, parameters: params, complete: { (res) in
            let response = ApiModel.init(json: res.convertToDictionary())
            self.delegate?.submitSuccess(response: response ?? "Error")
        }) { (er) in
            self.delegate?.submitFail(response: er)
        }
    }
}
