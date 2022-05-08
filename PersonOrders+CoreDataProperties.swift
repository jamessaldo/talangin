//
//  PersonOrders+CoreDataProperties.swift
//  Talangin
//
//  Created by zy on 08/05/22.
//
//

import Foundation
import CoreData


extension PersonOrders {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonOrders> {
        return NSFetchRequest<PersonOrders>(entityName: "PersonOrders")
    }

    @NSManaged public var total: Float
    @NSManaged public var person: People?
    @NSManaged public var orders: NSSet?
    @NSManaged public var transactions: Transactions?

}

// MARK: Generated accessors for orders
extension PersonOrders {

    @objc(addOrdersObject:)
    @NSManaged public func addToOrders(_ value: Orders)

    @objc(removeOrdersObject:)
    @NSManaged public func removeFromOrders(_ value: Orders)

    @objc(addOrders:)
    @NSManaged public func addToOrders(_ values: NSSet)

    @objc(removeOrders:)
    @NSManaged public func removeFromOrders(_ values: NSSet)

}

extension PersonOrders : Identifiable {

}
