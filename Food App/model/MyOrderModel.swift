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
    var order_id:Int?
    
        var cartId: String? = ""
        var totalPrice: Double? = 0
        var userPayPrice: Double?
        var discountPrice: Int?
        var deliverPrice: Int?
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
        var images: String?//[String]? = []
    var createdDate: String?//? = Date()

    enum CodingKeys: String, CodingKey {
        case order_id,state,images,city,phone,address,names,status
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
    var payload: OrderItemModel?
}
struct OrderItemModel:   Codable {
    let orderID: Int?
        let cartID: String?
        let totalPrice, userPayPrice: Double?
        let discountPrice, deliverPrice, deliverType, paymentType: Int?
        let paymentStatus, orderStatus, status: Int?
        let userName, phone, address, city: String?
        let state, postalCode, createdDate: String?
        let cartList: [CartList]?

        enum CodingKeys: String, CodingKey {
            case orderID = "order_id"
            case cartID = "cart_id"
            case totalPrice = "total_price"
            case userPayPrice = "user_pay_price"
            case discountPrice = "discount_price"
            case deliverPrice = "deliver_price"
            case deliverType = "deliver_type"
            case paymentType = "payment_type"
            case paymentStatus = "payment_status"
            case orderStatus = "order_status"
            case status
            case userName = "user_name"
            case phone, address, city, state
            case postalCode = "postal_code"
            case createdDate = "created_date"
            case cartList = "cart_list"
        }
}

struct CartList: Codable {
    let orderID, cartID, userID, prodID: Int?
    let qty, catID, brandID, typeID: Int?
    let name, detail, unitName, unitValue: String?
    let nutritionWeight: String?
    let price: Double?
    let createdDate, modifyDate, catName: String?
    let isFav: Int?
    let brandName, typeName: String?
    let offerPrice: Double?
    let startDate, endDate: String?
    let isOfferActive: Int?
    let image: String?
    let itemPrice, totalPrice: Double?
    let rating, reviewMessage: String?

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case cartID = "cart_id"
        case userID = "user_id"
        case prodID = "prod_id"
        case qty
        case catID = "cat_id"
        case brandID = "brand_id"
        case typeID = "type_id"
        case name, detail
        case unitName = "unit_name"
        case unitValue = "unit_value"
        case nutritionWeight = "nutrition_weight"
        case price
        case createdDate = "created_date"
        case modifyDate = "modify_date"
        case catName = "cat_name"
        case isFav = "is_fav"
        case brandName = "brand_name"
        case typeName = "type_name"
        case offerPrice = "offer_price"
        case startDate = "start_date"
        case endDate = "end_date"
        case isOfferActive = "is_offer_active"
        case image
        case itemPrice = "item_price"
        case totalPrice = "total_price"
        case rating
        case reviewMessage = "review_message"
    }
}
