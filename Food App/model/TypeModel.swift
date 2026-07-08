//
//  TypeModel.swift
//  Food App
//
//  Created by hosam on 08/07/2026.
//

import SwiftUI


struct HomeResModel:Codable {
    var status,message:String?
    
    var payload:HomeModel?
  }
struct HomeModel:Codable {
    var best_sell_list:[ProductModel]?
    var list:[ProductModel]?
    var type_list:[TypeModel]?
    var offer_list:[ProductModel]?
}
struct TypeModel:  Codable {
//    var id = UUID().uuidString
    var id:Int? = 0
    
    var type_id: Int? = 0
    var type_name: String? = ""
    var image: String? = ""
    var color:String? = ""
    
   
//    var color: Color = Color.primaryApp
}
