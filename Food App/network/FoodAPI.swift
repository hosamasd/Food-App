//
//  PaploAPI.swift
//  Publo Ultra
//
//
//

import Foundation
import SwiftUI

extension Bool {
    
}
let isiPad = UIDevice.current.userInterfaceIdiom == .pad

class FoodAPI {
    public static var shared = FoodAPI()
    
    func login(body:LoginPassModel)  async throws -> LoginResModel{
        return try await Network.POST_JSON(route: .Login, body: body)
    }
    
    func signUp(body:SignupPassModel)  async throws -> LoginResModel{
        return try await Network.POST_JSON(route: .signup, body: body)
    }
    
    func updateProfile(body:UpdateProfilePassModel)  async throws -> LoginResModel{
        return try await Network.POST_JSON(route: .updateProfile, body: body)
    }
    
    func forget(body:ForgetPassModel)  async throws -> LoginResModel{
        return try await Network.POST_JSON(route: .forget,auth:false, body: body)
    }
    
    func forget_verfiy(body:ForgetVerifyPassModel)  async throws -> LoginResModel{
        return try await Network.POST_JSON(route: .forget_verfiy,auth:false, body: body)
    }
    
    func forget_verfiy_setPass(body:ForgetVerifySetPassPassModel)  async throws -> LoginResModel{
        return try await Network.POST_JSON(route: .forgot_password_set_password,auth:false, body: body)
    }
    
    func getCarList(promo_code_id:Int,delivery_type:Int) async throws -> CartResModel {
            return try await Network.POST(route: .cart_list, body: ["promo_code_id":promo_code_id,"delivery_type":delivery_type])
        }
    

    func orderPlace(address_id:String,deliver_type:Int,payment_type:Int,pay_id:String,promo_code_id:Int? = nil) async throws -> CartSendResModel {
        let body:[String:Any] = ["address_id":address_id,"deliver_type":deliver_type,"payment_type":payment_type,"pay_id":pay_id,"promo_code_id":""]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            print(jsonString)
        }
        
        return try await Network.POST2(route: .orderPlace, body: body)
        
        
    }




func removeFromCart(cart_id:Int,prod_id:Int) async throws -> CartResModel {
        return try await Network.POST(route: .removeFromCart, body: ["cart_id":cart_id,"prod_id":prod_id])
    }

    func addToCart(prod_id:Int,qty:Int) async throws -> CartResModel {
            return try await Network.POST(route: .add_to_cart, body: ["prod_id":prod_id,"qty":qty])
        }
    func updateQty(cart_id:Int,prod_id:Int,new_qty:Int) async throws -> CartResModel {
        return try await Network.POST(route: .updateQty, body: ["cart_id":cart_id,"prod_id":prod_id,"new_qty":new_qty])
        }
    
    
    
    func getAddress()  async throws -> AddressResModel{
        return try await Network.POST(route: .getAddress, body: [:])
    }
    
    func exploreList()  async throws -> ExploreCategoryResModel{
        return try await Network.POST(route: .exploreList, body: [:])
    }
    
    func getProdcts(cat_id:Int)  async throws -> ProductResModel{
        return try await Network.POST(route: .getProdcts, body: ["cat_id":cat_id])
    }
    
    func addRemoveFav(prod_id:Int)  async throws -> ProductResModel{
        return try await Network.POST(route: .addRemoveFav, body: ["prod_id":prod_id])
    }
    
    
    func getPromoCode()  async throws -> PromoResModel{
        return try await Network.POST(route: .getPromoCode, body: [:])
    }
    
    func removeAddress(id:Int)  async throws -> AddressResModel{
        return try await Network.POST(route: .deleteAddres, body: ["address_id":id])
    }
    
    func addAddres(body:AddressSendModel)  async throws -> AddressResModel{
        return try await Network.POST_JSON(route: .addAddres,auth:true, body: body)
    }
    
    func updateAddres(body:AddressSendModel)  async throws -> AddressResModel{
        return try await Network.POST_JSON(route: .updateAddres,auth:true, body: body)
    }
    
    func readAllNotification()  async throws -> LoginResModel{
        return try await Network.POST(route: .readAllNotification, body: [:])
    }
    func getAllNotification()  async throws -> NotificationResModel{
        return try await Network.POST(route: .getAllNotification, body: [:])
    }
    func getFavorites()  async throws -> ProductResModel{
        return try await Network.POST(route: .getFavorites, body: [:])
    }
    
    func getHome()  async throws -> HomeResModel{
        return try await Network.POST(route: .getHome, body: [:])
    }
    
    func getMyOrders()  async throws -> MyOrderResModel{
        return try await Network.POST(route: .getMyOrders, body: [:])
    }
    func payment_method()  async throws -> PaymentResModel{
        return try await Network.POST(route: .payment_method, body: [:])
    }
    func addPayment(body:PaymentAddModel)  async throws -> PaymentResModel{
        return try await Network.POST_JSON(route: .addPayment, body: body)
    }
    
    func my_order_detail(id:Int)  async throws -> MyOrderItemResModel{
        return try await Network.POST(route: .my_order_detail, body: ["order_id":id])
    }
    func removePayment(id:Int)  async throws -> PaymentResModel{
        return try await Network.POST(route: .removePayment, body: ["pay_id":id])
    }
    
    
    
}
