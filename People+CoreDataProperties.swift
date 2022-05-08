//
//  People+CoreDataProperties.swift
//  Talangin
//
//  Created by zy on 08/05/22.
//
//

import Foundation
import CoreData


extension People {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<People> {
        return NSFetchRequest<People>(entityName: "People")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?

}

extension People : Identifiable {

}
