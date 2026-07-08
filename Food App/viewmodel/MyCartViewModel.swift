//
//  MyCartViewModel.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

class MyCartViewModel: ObservableObject {
    @Published var isLoading=false
    @Published var alertMsg=""
    @Published var alert=false
        @Published var alertError=false
    
    @Published var listArr=[CartItemModel]()
    @Published var total: String = "0.0"
    
    @Published var showCheckout: Bool = false
    @Published var showOrderAccept = false

    @Published var showPickerAddress: Bool = false
    @Published var showPickerPayment: Bool = false
    @Published var showPickerPromoCode: Bool = false
    
    @Published var deliveryType: Int = 1
    @Published var paymentType: Int = 1
    @Published var deliverObj: AddressModel?
    @Published var paymentObj: PaymentModel?
    @Published var promoObj: PromoCodeModel?
    
    @Published var deliverPriceAmount: String = ""
    @Published var discountAmount: String = ""
    @Published var userPayAmount: String = ""
    
    init() {
        serviceCallList()
    }
    
    
    
    //MARK: ServiceCall
    
    func serviceCallList(){
        
        if  !Reachability.isConnectedToNetwork(){
        }else{
            withAnimation{isLoading.toggle()}
            
            Task
            {
                do {
                    
                    
                    let res: CartResModel = try         await FoodAPI().getCarList(promo_code_id: promoObj?.id ?? 0, delivery_type: deliveryType)
                    
                    Task{@MainActor in
                        if let err=Int(res.status ?? "1"),err==0 {
                            self.serverError(message: res.message)
                            self.total = res.total ?? "0.0"
                            self.discountAmount = res.discount_amount ?? "0.0"
                            self.deliverPriceAmount = res.deliver_price_amount ?? "0.0"
                            self.userPayAmount = res.user_pay_price ?? "0.0"
                        }else{
                            isLoading=false
                            self.total = res.total ?? "0.0"
                            self.discountAmount = res.discount_amount ?? "0.0"
                            self.deliverPriceAmount = res.deliver_price_amount ?? "0.0"
                            self.userPayAmount = res.user_pay_price ?? "0.0"
                            self.listArr=res.payload ?? []
                        }
                    }
                }
                catch let error as Network.NetworkError
                {
                    showErro(error2: error)
                    Task{@MainActor in
                        isLoading=false
                    }
                }
            }
        }
    }
    
    func UpdateQty(cObj: CartItemModel, newQty: Int)  {
        if  !Reachability.isConnectedToNetwork(){
         }else{
             withAnimation{isLoading.toggle()}
             
             Task
             {
                 do {
                     let res: CartResModel = try         await FoodAPI().updateQty(cart_id: cObj.cartId ?? 1, prod_id: cObj.prodId ?? 1, new_qty: newQty)
                     
                     Task{@MainActor in
                         if let err=Int(res.status ?? "0"),err==0 {
                             self.serverError(message: res.message)
                         }else{
                             self.serviceCallList()

                        }
                    }
                 }
                 catch let error as Network.NetworkError
                 {
                     showErro(error2: error)
                     Task{@MainActor in
                         isLoading=false
                         
                     }
                 }
             }
         }
    }
    
    func addToCart(prodId: Int, qty: Int, didDone: ((_ isDone: Bool,_ message: String  )->())?)  {
        if  !Reachability.isConnectedToNetwork(){
         }else{
             withAnimation{isLoading.toggle()}
             
             Task
             {
                 do {
                     let res: CartResModel = try         await FoodAPI().addToCart(prod_id: prodId, qty: qty)
                     
                     Task{@MainActor in
                         if let err=Int(res.status ?? "1"),err==0 {
                             didDone?(true, res.message ?? "Done" )

                         }else{
                             isLoading=false
                             didDone?(false, res.message ?? "Fail" )

                        }
                    }
                 }
                 catch let error as Network.NetworkError
                 {
                     showErro(error2: error)
                     Task{@MainActor in
                         isLoading=false
                         didDone?(false, error.localizedDescription ?? "Fail" )

                     }
                 }
             }
         }
    }

    
    func removeFromCart(cObj: CartItemModel)  {
        if  !Reachability.isConnectedToNetwork(){
         }else{
             withAnimation{isLoading.toggle()}
             
             Task
             {
                 do {
                     let res: CartResModel = try         await FoodAPI().removeFromCart(cart_id: cObj.cartId ?? 1, prod_id: cObj.prodId ?? 1)
                     
                     Task{@MainActor in
                         if let err=Int(res.status ?? "0"),err==0 {
                             self.serverError(message: res.message)
                         }else{
//                             isLoading=false
                             self.serviceCallList()
                        }
                    }
                 }
                 catch let error as Network.NetworkError
                 {
                     showErro(error2: error)
                     Task{@MainActor in
                         isLoading=false
                     }
                 }
             }
         }
    }
    
        func orderPlace(){
            if(deliveryType == 1 && deliverObj == nil ) {
                self.alertMsg = "Please select delivery address"
                self.alertError = true
                return
            }
            
            if(paymentType == 2 && paymentObj == nil ) {
                self.alertMsg = "Please select payment method"
                self.alertError = true
                return
            }
            let promo_code_id:Int? = promoObj?.id ?? nil
            
            
            if  !Reachability.isConnectedToNetwork(){
             }else{
                 withAnimation{isLoading.toggle()}
                 
                 Task
                 {
                     do {
                         let res: CartSendResModel = try         await FoodAPI().orderPlace(address_id:deliveryType == 2 ? "" : "\( deliverObj?.address_id ?? 0)",deliver_type: deliveryType,payment_type: paymentType,pay_id: paymentType == 1 ? "" : "\( paymentObj?.id ?? 0)",promo_code_id: promo_code_id )
                         
                         Task{@MainActor in
                             if let err=Int(res.status ?? "1"),err==0 {
                                 self.serverError(message: res.message ?? "")
                             }else{
    //                             isLoading=false
                                 self.deliverObj = nil
                                 self.paymentObj = nil
                                 self.promoObj = nil
                                 self.showCheckout = false
                                 self.alertMsg = res.message ??  "Success"
                                 self.alertError = true
                                 self.serviceCallList()
                                 
                                 self.showOrderAccept = true
                            }
                        }
                     }
                     catch let error as Network.NetworkError
                     {
                         showErro(error2: error)
                         Task{@MainActor in
                             isLoading=false
                         }
                     }
                 }
             }
        }
        
    func serverError(message:String?)  {
        self.alertMsg=message ?? ""
        self.alertError=true
        self.isLoading=false
    }
    
    func showErro(error2:Network.NetworkError,isBarcode:Bool=false) {
        
        switch error2{
        case .serverError(let s):
            DispatchQueue.main.async {
                
                //                self.isLoading=false
                
                self.alertMsg=s.message
                self.alertError=true
            }
            
            
        case .invalidateSession(let s):
            DispatchQueue.main.async {
                //                self.isLoading=false
                self.alertMsg=s
                self.alertError=true
            }
        case .notAutherized:
            DispatchQueue.main.async {
                //                self.isLoading=false
                self.alertMsg="Not Autherized"
                self.alertError=true
            }
            
        case .invalidResponse(_, let s):
            DispatchQueue.main.async {
                //                self.isLoading=false
                self.alertMsg=s
                self.alertError=true
            }
        case .connectivity:
            DispatchQueue.main.async {
                //                self.isLoading=false
                self.alertMsg="Not Connected"
                self.alertError=true
            }
        case .decodingError(let s, _, _):
            DispatchQueue.main.async {
                //                self.isLoading=false
                self.alertMsg=s.localizedDescription
                //                self.alert=true
                self.alertError=true
                
            }
        case .timeout:
            DispatchQueue.main.async {
                self.isLoading=false
                self.alertMsg="The request deadline has ended. Please try again later."
                self.alertError=true
            }
        }
    }
}
