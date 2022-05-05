//
//  TransactionModel.swift
//  Talangin
//
//  Created by zy on 27/04/22.
//

import Foundation

struct TransactionModel {
    var title: String = ""
    var amount: Float = 0
    var date: Date = Date()
    var personsOrders: [PersonsOrdersModel] = []
    var orders: [OrderModel] = []
}

struct OrderModel {
    var name: String = ""
    var quantity: Int = 0
    var price: Float = 0
    var amount: Float = 0
    var totalMember: Int = 0
}

struct PersonsOrdersModel {
    var person: ContactModel?
    var total: Float = 0
    var orders: [OrderModel] = []
}
