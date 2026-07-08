//
//  UserModel.swift
//  Food App
//
//  Created by hosam on 06/07/2026.
//

import SwiftUI

struct LoginPassModel:Codable {
    var email:String
    var password:String
    var dervice_token:String
}

struct SignupPassModel:Codable {
    var username,email:String
    var password:String
    var dervice_token:String
}
struct ForgetPassModel:Codable {
    var email:String
//    var dervice_token:String
}
struct ForgetVerifyPassModel:Codable {
    var email:String
    var reset_code:Int
    
}
struct ForgetVerifySetPassPassModel:Codable {
    var user_id:Int
        var new_password:String
    var reset_code:Int
}
struct UpdateProfilePassModel:Codable {
    var username,name,mobile,mobile_code:String
}

struct LoginResModel: Codable {
    var status:String?
    var message:String?
    var payload: UserModel?
    
}


struct UserModel: Codable {
    var user_id:Int? = 0
    
    var id: Int? = 0
    var username: String?
    var name: String?
    var email: String?
    var mobile: String?
    var mobileCode: String?
    var authToken: String?
    var reset_code:String? 
    
    enum CodingKeys: String, CodingKey {
        case mobile,email,name,username,id,user_id,reset_code
        case mobileCode = "mobile_code"
        case authToken = "auth_token"

    }
    
//    init(dict: NSDictionary) {
//        self.id = dict.value(forKey: "user_id") as? Int ?? 0
//        self.username = dict.value(forKey: "username") as? String ?? ""
//        self.name = dict.value(forKey: "name") as? String ?? ""
//        self.email = dict.value(forKey: "email") as? String ?? ""
//        self.mobile = dict.value(forKey: "mobile") as? String ?? ""
//        self.mobileCode = dict.value(forKey: "mobile_code") as? String ?? ""
//        self.authToken = dict.value(forKey: "auth_token") as? String ?? ""
//    }
//    
//    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
//        return lhs.id == rhs.id
//    }
}

