//
//  Transactions+CoreDataProperties.swift
//  Talangin
//
//  Created by zy on 08/05/22.
//
//

import Foundation
import CoreData


extension Transactions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transactions> {
        return NSFetchRequest<Transactions>(entityName: "Transactions")
    }

    @NSManaged public var title: String?
    @NSManaged public var amount: Float
    @NSManaged public var date: Date?
    @NSManaged public var personOrders: NSSet?
    @NSManaged public var orders: NSSet?

}

// MARK: Generated accessors for personOrders
extension Transactions {

    @objc(addPersonOrdersObject:)
    @NSManaged public func addToPersonOrders(_ value: PersonOrders)

    @objc(removePersonOrdersObject:)
    @NSManaged public func removeFromPersonOrders(_ value: PersonOrders)

    @objc(addPersonOrders:)
    @NSManaged public func addToPersonOrders(_ values: NSSet)

    @objc(removePersonOrders:)
    @NSManaged public func removeFromPersonOrders(_ values: NSSet)

}

// MARK: Generated accessors for orders
extension Transactions {

    @objc(addOrdersObject:)
    @NSManaged public func addToOrders(_ value: Orders)

    @objc(removeOrdersObject:)
    @NSManaged public func removeFromOrders(_ value: Orders)

    @objc(addOrders:)
    @NSManaged public func addToOrders(_ values: NSSet)

    @objc(removeOrders:)
    @NSManaged public func removeFromOrders(_ values: NSSet)

}

extension Transactions : Identifiable {

}
