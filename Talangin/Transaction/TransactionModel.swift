//
//  TransactionModel.swift
//  Talangin
//
//  Created by zy on 27/04/22.
//

import Foundation

struct TransactionModel {
    var title: String
    var amount: Float
    var date: Date
    var personsOrders: [PersonsOrdersModel]
    var orders: [OrderModel]
}

struct OrderModel {
    var name: String
    var quantity: Int
    var price: Float
    var amount: Float
}

struct PersonsOrdersModel {
    var person: ContactModel
    var total: Float
    var orders: [OrderModel]
}
