//
//  AsyncImageView.swift
//  demoApplication
//
//  Created by Macbook  on 8/22/20.
//  Copyright © 2020 mtvd. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

func getCurrentDate() -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "dd"
    let dateResult = formatter.string(from: date)
    
    return dateResult
}

class AsyncImageView: UIImageView {
    var imageUrlString: String?
    
    func loadImgUsingUrlString(urlString: String) {
        imageUrlString = urlString
        
        guard let url = URL(string: urlString) else { return }
        let urlRes = URLRequest(url: url)
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }

        let task = URLSession.shared.dataTask(
            with: urlRes,
            completionHandler: { data, response, error in
                if let error = error {
                    print(error)
                    return
                }
                
                if let data = data {
                    DispatchQueue.main.async(execute: {
                        let imageToCache = UIImage(data: data)
                        
                        if self.imageUrlString == urlString {
                            self.image = UIImage(data: data)
                        }
                        if let imageToCache = imageToCache {
                            imageCache.setObject(imageToCache, forKey: urlString as NSString)
                        }
                    })
                }
        })
        task.resume()
    }
}
