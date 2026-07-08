//
//  CartItemModel.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

struct CartResModel: Codable {
    var status:String?
    var message:String?
    var payload: [CartItemModel]?
    var total,discount_amount,deliver_price_amount,user_pay_price:String?

}
struct CartSendResModel: Codable {
    var status:String?
    var message:String?
    var payload: CartSuccessResModel?
}

struct CartSuccessResModel: Codable {
    var orderID: Int?
//    var cartID: String?
    var totalPrice, userPayPrice,deliverPrice,discountPrice: Double?
//    var  deliverType, paymentType: Int?
//    var paymentStatus, orderStatus, status: Int?
//    var createdDate, names: String?
//    var images: String?
//    var userName, phone, address, city: String?
//    var state, postalCode: String?

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
//        case cartID = "cart_id"
        case totalPrice = "total_price"
        case userPayPrice = "user_pay_price"
        case discountPrice = "discount_price"
        case deliverPrice = "deliver_price"
    }

}


struct CartItemModel:Identifiable, Codable {
    var id: UUID = UUID()
    var cartId: Int? = 0
    var userId: Int? = 0
    var qty: Int? = 0
    var prodId: Int? = 0
    var catId: Int? = 0
    var brandId: Int? = 0
    var typeId: Int? = 0
    var brandName: String? = ""
    var detail: String? = ""
    var name: String? = ""
    var unitName: String? = ""
    var unitValue: String? = ""
    var nutritionWeight: String? = ""
    var image: String? = ""
    var catName: String? = ""
    var typeName: String? = ""
    var offerPrice: Double?
    var price: Double? = 0
    var startDate: String? = ""
    var endDate: String? = ""
    var itemPrice: Double?
    var totalPrice: Double?
    var isFav: Int? = 0
    
    enum CodingKeys: String, CodingKey {
        case price,image,name,detail,qty
        case cartId = "cart_id"
        case userId = "user_id"
        case prodId = "prod_id"
        case catId = "cat_id"
        case brandId = "brand_id"
        case typeId = "type_id"
        case brandName = "brand_name"
        case unitName = "unit_name"
        case nutritionWeight = "nutrition_weight"
        case unitValue = "unit_value"
        case catName="cat_name"
        
        case typeName = "type_name"
        case offerPrice = "offer_price"
        case endDate = "end_date"
        case startDate = "start_date"
        case itemPrice = "item_price"
        case totalPrice="total_price"
        case isFav="is_fav"

    }
}
