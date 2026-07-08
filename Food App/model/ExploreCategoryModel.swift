//
//  ExploreCategoryModel.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

struct ExploreCategoryResModel: Codable {
    var status:String?
    var message:String?
    var payload: [ExploreCategoryModel]?
    
}
struct ExploreCategoryModel: Codable {
    var id: Int? = 0
    var cat_id:Int? = 0
    
    var cat_name: String? = ""
    var image: String? = ""
    var color:String? 
    
//    var color: Color? = Color.primaryApp
}
struct ProductResModel: Codable {
    var status:String?
    var message:String?
    var payload: [ProductModel]?
    
}
struct ProductModel:  Codable {
    var id: Int? = 0
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
    var startDate: String? = ""
    var endDate: String? = ""
    var isFav: Int? = 0
    var avgRating: Int? = 0
    var fav_id:Int?
    var brand_name:String?
    var is_offer_active:Int?
    
    enum CodingKeys: String, CodingKey {
        case price,image,name,detail,qty,fav_id,brand_name,is_offer_active
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
        case avgRating="avg_rating"

        case brandId = "brand_id"
        case typeId = "type_id"
        case catId = "cat_id"
        case prodId="prod_id"
    }
    
}

struct NutritionModel: Identifiable, Equatable {
    
    var id: Int? = 0
    var nutritionName: String? = ""
    var nutritionValue: String? = ""
    enum CodingKeys: String, CodingKey {
        case nutritionName="nutrition_name"
        case nutritionValue="nutrition_value"
    }
}

struct ImageModel: Codable {
    
    var id: Int? = 0
    var prodId: Int? = 0
    var image: String? = ""
    enum CodingKeys: String, CodingKey {
        
        case prodId="prod_id"
    }

}
