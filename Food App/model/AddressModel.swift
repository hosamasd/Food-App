//
//  AddressModel.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

struct AddressSendModel: Codable {
    var address_id:Int?
    
    var name,type_name,phone,address,city,state,postal_code:String?
    
}
struct AddressResModel: Codable {
    var status:String?
    var message:String?
    var payload: [AddressModel]?

}
struct AddressModel:  Codable {
    
    var id: Int? = 0
    var address_id:Int? = 0
    
    var name: String? = ""
    var phone: String? = ""
    var address: String? = ""
    var city: String? = ""
    var state: String? = ""
    var typeName: String? = ""
    var postalCode: String? = ""
    var isDefault: Int? = 0
    
    enum CodingKeys: String, CodingKey {
        case state,city,address,phone,name,id,address_id
        case typeName = "type_name"
        case postalCode = "postal_code"
        case isDefault = "is_default"
    }
}
