//
//  PromoCodeModel.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

struct PromoResModel: Codable {
    var status:String?
    var message:String?
    var payload: [PromoCodeModel]?

}
struct PromoCodeModel: Codable {
    var id: Int? = 0
    var type: Int? = 0
    
    var title: String? = ""
    var code: String? = ""
    var description: String? = ""
    var startDate: Date? = Date()
    var endDate: Date? = Date()
    var minOrderAmount : Double? = 0.0
    var maxDiscountAmount : Double? = 0.0
    var offerPrice: Double? = 0.0
    
    enum CodingKeys: String, CodingKey {
        case maxDiscountAmount = "max_discount_amount"
        case offerPrice = "offer_price"
        case minOrderAmount = "min_order_amount"

        case endDate = "end_date"
        case startDate = "start_date"
    }
}
