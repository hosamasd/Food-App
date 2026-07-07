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
    var startDate: Date? = Date()
    var endDate: Date? = Date()
    var itemPrice: Double?
    var totalPrice: Double?
    var isFav: Bool? = false
    
    enum CodingKeys: String, CodingKey {
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
