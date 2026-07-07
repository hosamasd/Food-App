//
//  ExploreViewModel.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

class ExploreViewModel: ObservableObject {
    @Published var currentUser=UserModel()
    @AppStorage("isUserLogin") var isUserLogin: Bool = false
    @Published var isLoading=false
    @Published var alertMsg=""
    @Published var alert=false
        @Published var alertError=false
    
    @Published var txtSearch: String = ""

    @Published var listArr: [ExploreCategoryModel] = []
    @Published var listProductArr: [ProductModel] = []

    @Published var nutritionArr: [NutritionModel] = []
    @Published var imageArr: [ImageModel] = []
    
    
    @Published var isFav: Bool = false
    @Published var isShowDetail: Bool = false
    @Published var isShowNutrition: Bool = false
    @Published var qty: Int = 1
    
    init() {
        serviceCallList()
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

    
    func showDetail()  {
        isShowDetail = !isShowDetail

    }
    
    func showNutrition(){
        isShowNutrition = !isShowNutrition
    }
    
    func addSubQTY(isAdd: Bool = true)  {
        if(isAdd) {
            qty += 1
            if(qty > 99) {
                qty = 99
            }
        }else{
            qty -= 1
            if(qty < 1) {
                qty = 1
            }
        }
    }
    
    func serviceCallAddRemoveFav(pObj:ProductModel)  {
        if  !Reachability.isConnectedToNetwork(){
         }else{
             withAnimation{isLoading.toggle()}
             
             Task
             {
                 do {
                     let res: ProductResModel = try         await FoodAPI().addRemoveFav(prod_id: pObj.prodId ?? 1 )
                     
                     Task{@MainActor in
                         if let err=Int(res.status ?? "0"),err==0 {
                             self.serverError(message: res.message)
                         }else{
                             isLoading=false
                             if let arr=res.payload{
                                 self.listProductArr=arr
                             }

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
    
    func getProdcts(cObj:ExploreCategoryModel)  {
        
        if  !Reachability.isConnectedToNetwork(){
         }else{
             withAnimation{isLoading.toggle()}
             
             Task
             {
                 do {
                     let res: ProductResModel = try         await FoodAPI().getProdcts(cat_id: cObj.id ?? 1 )
                     
                     Task{@MainActor in
                         if let err=Int(res.status ?? "0"),err==0 {
                             self.serverError(message: res.message)
                         }else{
//                             isLoading=false
                             self.isFav = !self.isFav
                             self.serviceCallList()
                             
                             self.alertMsg = res.message ?? "Done"
                             self.alertError = true

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
    
    //MARK: ServiceCall
    func serviceCallList(){
        
        if  !Reachability.isConnectedToNetwork(){
         }else{
             withAnimation{isLoading.toggle()}
             
             Task
             {
                 do {
                     let res: ExploreCategoryResModel = try         await FoodAPI().exploreList()
                     
                     Task{@MainActor in
                         if let err=Int(res.status ?? "0"),err==0 {
                             self.serverError(message: res.message)
                         }else{
                             isLoading=false
                             if let arr=res.payload{
                                 self.listArr=arr
                             }

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
