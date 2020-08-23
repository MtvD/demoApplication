//
//  UserData+CoreDataProperties.swift
//  
//
//  Created by Macbook  on 8/23/20.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged public var username: String?
    @NSManaged public var password: String?
    @NSManaged public var token: String?

}
