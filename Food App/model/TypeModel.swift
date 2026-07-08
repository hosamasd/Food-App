//
//  TypeModel.swift
//  Food App
//
//  Created by hosam on 08/07/2026.
//

import SwiftUI


struct HomeModel:Codable {
    var status,message:String? 
    
    var offer_list:[ProductModel]?
    var best_sell_list:[ProductModel]?
    var list:[ProductModel]?
    var type_list:[TypeModel]?
    
    
}
struct TypeModel: Identifiable, Codable {
    
    var id: Int? = 0
    var name: String? = ""
    var image: String? = ""
//    var color: Color = Color.primaryApp
}
