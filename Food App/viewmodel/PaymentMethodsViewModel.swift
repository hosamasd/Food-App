//
//  PaymentMethodsViewModel.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

class PaymentMethodsViewModel: ObservableObject {
    @Published var isLoading=false
    @Published var alertMsg=""
    @Published var alert=false
        @Published var alertError=false
    
    @Published var txtName: String = ""
    @Published var txtCardNumber: String = ""
    @Published var txtCardMonth: String = ""
    @Published var txtCardYear: String = ""
    

    @Published var listArr: [PaymentModel] = []

    init() {
        serviceCallList()
    }
    
    func serviceCallList(){
        if  !Reachability.isConnectedToNetwork(){
        }else{
            withAnimation{isLoading.toggle()}
            
            Task
            {
                do {
                    
                    
                    let res: PaymentResModel = try         await FoodAPI().payment_method()
                    
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
    
    func removePayment(pObj: PaymentModel)  {
        if  !Reachability.isConnectedToNetwork(){
        }else{
            withAnimation{isLoading.toggle()}
            
            Task
            {
                do {
                    
                    
                    let res: PaymentResModel = try         await FoodAPI().removePayment(id: pObj.pay_id ?? 1)
                    
                    Task{@MainActor in
                        if let err=Int(res.status ?? "0"),err==0 {
                            self.serverError(message: res.message)
                        }else{
                            isLoading=false
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
    
    func getPayments() -> PaymentAddModel {
        return .init(name: txtName,card_number: txtCardNumber, card_month: txtCardMonth, card_year: txtCardYear)
    }
    
    func serviceCallAdd(didDone: ((  )->())? ) {
        
        if(txtName.isEmpty) {
            alertMsg = "please enter name"
            alertError = true
            return
        }
        
        if(txtCardNumber.count != 16) {
            alertMsg = "please enter valid card number"
            alertError = true
            return
        }
        
        
        if(txtCardMonth.count != 2) {
            alertMsg = "please enter valid card month"
            alertError = true
            return
        }
        
        if(txtCardYear.count != 4) {
            alertMsg = "please enter valid card year"
            alertError = true
            return
        }
        
        if  !Reachability.isConnectedToNetwork(){
        }else{
            withAnimation{isLoading.toggle()}
            
            Task
            {
                do {
                    let payment = getPayments()

                    
                    let res: PaymentResModel = try         await FoodAPI().addPayment(body:payment)
                    
                    Task{@MainActor in
                        if let err=Int(res.status ?? "0"),err==0 {
                            self.serverError(message: res.message)
                        }else{
                            isLoading=false
                            self.clearAll()
                            self.serviceCallList()
                            didDone?( )
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
    func clearAll(){
        txtName = ""
        txtCardNumber = ""
        txtCardYear = ""
        txtCardMonth = ""
        
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
