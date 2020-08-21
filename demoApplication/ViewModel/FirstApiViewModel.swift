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
            "from" : "2020-07-21",
            "sortBy" : "publishedAt",
            "apiKey" : "4c78908e21b24d84bc56cb462d3e4424"
        ]
        
        _ = APIService.shared.requestApiWith(url: APIService.shared.url(type: .api1), parameters: params, complete: { (res) in
            let response = ApiModel.init(json: res.convertToDictionary())
            self.delegate?.submitSuccess(response: response ?? [])
        }) { (er) in
            self.delegate?.submitFail(response: er)
        }
    }
}

extension String {
    func convertToDictionary() -> [String : Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func convertToArray() -> [AnyObject]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [AnyObject]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
