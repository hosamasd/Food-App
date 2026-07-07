//
//  PaymentModel.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

struct PaymentResModel: Codable {
    var status:String?
    var message:String?
    var payload: [PaymentModel]?
}
struct PaymentAddModel: Codable {
    var name,card_number,card_month,card_year:String?
}
struct PaymentModel: Codable {
    var id: Int? = 0
    var name: String? = ""
    var cardNumber: String? = ""
    var cardMonth: String? = ""
    var cardYear: String? = ""
    
    enum CodingKeys: String, CodingKey {
        case cardMonth = "card_month"
        case cardYear = "card_year"
        case cardNumber = "card_number"

    }
}
