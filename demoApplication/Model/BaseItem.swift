//
//  BaseItem.swift
//  demoApplication
//
//  Created by Macbook  on 8/19/20.
//  Copyright © 2020 mtvd. All rights reserved.
//

import UIKit

class BaseItem: NSObject, NSCoding{
    
    init?(json : [String :  Any]?){
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
    }
    
    func encode(with aCoder: NSCoder) {
        
    }
}
