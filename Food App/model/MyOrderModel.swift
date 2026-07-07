//
//  MyOrderModel.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

struct MyOrderResModel: Codable {
    var status:String?
    var message:String?
    var payload: [MyOrderModel]?
}
struct MyOrderModel: Codable {
        var id: Int? = 0
        var cartId: Int? = 0
        var totalPrice: Double? = 0
        var userPayPrice: Double?
        var discountPrice: Double?
        var deliverPrice: Double?
        var deliverType: Int? = 0
        var paymentType: Int? = 0
        var paymentStatus: Int? = 0
        var orderStatus: Int? = 0
        var status: Int? = 0
        var names: String? = ""
        var userName: String? = ""
        var phone: String? = ""
        var address: String? = ""
        var city: String? = ""
        var state: String? = ""
        var postalCode: String? = ""
        var images: [String]? = []
    var createdDate: Date? = Date()

    enum CodingKeys: String, CodingKey {
        case postalCode = "postal_code"
        case userName = "user_name"
        case orderStatus = "order_status"
        case paymentStatus = "payment_status"
        case paymentType = "payment_type"
        case deliverType = "deliver_type"
        case discountPrice = "discount_price"
        case deliverPrice = "deliver_price"
        case userPayPrice = "user_pay_price"
        case totalPrice = "total_price"
        case cartId = "cart_id"
        case createdDate="created_date"

    }
}

struct MyOrderItemResModel: Codable {
    var status:String?
    var message:String?
    var payload: [OrderItemModel]?
}
struct OrderItemModel:  Identifiable, Codable {
    var id: UUID = UUID()
    var prodId: Int? = 0
    var catId: Int? = 0
    var brandId: Int? = 0
    var typeId: Int? = 0
    var orderId: Int? = 0
    var qty: Int? = 0
    var detail: String? = ""
    var name: String? = ""
    var unitName: String? = ""
    var unitValue: String? = ""
    var nutritionWeight: String? = ""
    var image: String? = ""
    var catName: String? = ""
    var typeName: String? = ""
    var offerPrice: Double?
    var itemPrice: Double? = 0.0
    var totalPrice: Double? = 0.0
    var price: Double? = 0
    var startDate: Date? = Date()
    var endDate: Date? = Date()
    var isFav: Bool? = false
    var rating: Int? = 0
    var message: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case isFav = "is_fav"
        case endDate = "end_date"
        case startDate = "start_date"
        case totalPrice = "total_price"
        case itemPrice = "item_price"
        case offerPrice = "offer_price"
        case typeName = "type_name"
        case catName = "cat_name"
        case nutritionWeight = "nutrition_weight"
        case unitValue = "unit_value"
        case unitName = "unit_name"
        case orderId="order_d"
        
        case brandId = "brand_id"
        case typeId = "type_id"
        case catId = "cat_id"
        case prodId="prod_id"
    }
}
