//
//  Orders+CoreDataProperties.swift
//  Talangin
//
//  Created by zy on 08/05/22.
//
//

import Foundation
import CoreData


extension Orders {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Orders> {
        return NSFetchRequest<Orders>(entityName: "Orders")
    }

    @NSManaged public var name: String?
    @NSManaged public var quantity: Int32
    @NSManaged public var price: Float
    @NSManaged public var amount: Int32
    @NSManaged public var totalMembers: Int32
    @NSManaged public var transaction: Transactions?
    @NSManaged public var personOrders: NSSet?

}

// MARK: Generated accessors for personOrders
extension Orders {

    @objc(addPersonOrdersObject:)
    @NSManaged public func addToPersonOrders(_ value: PersonOrders)

    @objc(removePersonOrdersObject:)
    @NSManaged public func removeFromPersonOrders(_ value: PersonOrders)

    @objc(addPersonOrders:)
    @NSManaged public func addToPersonOrders(_ values: NSSet)

    @objc(removePersonOrders:)
    @NSManaged public func removeFromPersonOrders(_ values: NSSet)

}

extension Orders : Identifiable {

}
