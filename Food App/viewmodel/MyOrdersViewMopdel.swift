//
//  MyOrdersViewMopdel.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

class MyOrdersViewModel: ObservableObject {
    @Published var isLoading=false
    @Published var alertMsg=""
    @Published var alert=false
        @Published var alertError=false
    
    @Published var listArr=[MyOrderModel]()
    @Published var listArrItems: [OrderItemModel] = []

    init() {
        serviceCallList()
    }
    
    func getOrderById(id:Int)  {
        if  !Reachability.isConnectedToNetwork(){
        }else{
            withAnimation{isLoading.toggle()}
            
            Task
            {
                do {
                    
                    
                    let res: MyOrderItemResModel = try         await FoodAPI().my_order_detail(id:id)
                    
                    Task{@MainActor in
                        if let err=Int(res.status ?? "0"),err==0 {
                            self.serverError(message: res.message)
                        }else{
                            isLoading=false
                            if let arr=res.payload{
                                self.listArrItems=arr
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
    
    func serviceCallList(){
        if  !Reachability.isConnectedToNetwork(){
        }else{
            withAnimation{isLoading.toggle()}
            
            Task
            {
                do {
                    
                    
                    let res: MyOrderResModel = try         await FoodAPI().getMyOrders()
                    
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
