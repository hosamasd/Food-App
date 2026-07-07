//
//  DelieryAddressViewModel.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

class DelieryAddressViewModel: ObservableObject {
    @Published var isLoading=false
    @Published var alertMsg=""
    @Published var alert=false
        @Published var alertError=false
    
    @Published var listArr=[AddressModel]()
    @Published var txtName: String = ""
    @Published var txtMobile: String = ""
    @Published var txtAddress: String = ""
    @Published var txtCity: String = ""
    @Published var txtState: String = ""
    @Published var txtPostalCode: String = ""
    @Published var txtTypeName: String = "Home"
    
    init() {
        serviceCallList()
    }
    
    func serviceCallList()  {
        if  !Reachability.isConnectedToNetwork(){
        }else{
            withAnimation{isLoading.toggle()}
            
            Task
            {
                do {
                    let res: AddressResModel = try         await FoodAPI().getAddress()
                    
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
    
    func updateAddress(address:AddressModel?, didDone: (( )->())?)  {
        if  !Reachability.isConnectedToNetwork(){
         }else{
             withAnimation{isLoading.toggle()}
             
             Task
             {
                 do {
                     
                     let body = updateAddres(add:address)
                     
                     let res: AddressResModel = try         await FoodAPI().updateAddres(body: body  )
                     
                     Task{@MainActor in
                         if let err=Int(res.status ?? "1"),err==0 {
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
    
    
    func updateAddres(add:AddressModel?) -> AddressSendModel {
        return .init(address_id: add?.id ?? 0,name: txtName,type_name:txtTypeName,phone: txtMobile,address:txtAddress,city: txtCity,state: txtState,postal_code:txtPostalCode)
    }
    func getAddres() -> AddressSendModel {
        return .init(name: txtName,type_name:txtTypeName,phone: txtMobile,address:txtAddress,city: txtCity,state: txtState,postal_code:txtPostalCode)
    }
    
    func addAddress(didDone: ((  )->())?)  {
       if  !Reachability.isConnectedToNetwork(){
        }else{
            withAnimation{isLoading.toggle()}
            
            Task
            {
                do {
                    
                    let body = getAddres()
                    
                    let res: AddressResModel = try         await FoodAPI().addAddres(body: body  )
                    
                    Task{@MainActor in
                        if let err=Int(res.status ?? "1"),err==0 {
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
    
    func serviceCallRemove(cObj:AddressModel)  {
        if  !Reachability.isConnectedToNetwork(){
        }else{
            withAnimation{isLoading.toggle()}
            
            Task
            {
                do {
                    let res: AddressResModel = try         await FoodAPI().removeAddress(id: cObj.id ?? 1 )
                    
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
    
    func setData(aObj:AddressModel)  {
        txtName = aObj.name ?? ""
        txtMobile = aObj.phone ?? ""
        txtAddress = aObj.address ?? ""
        txtCity = aObj.city ?? ""
        txtState = aObj.state ?? ""
        txtPostalCode = aObj.postalCode ?? ""
        txtTypeName = aObj.typeName ?? ""
    }
    
    func clearAll(){
        txtName = ""
        txtMobile = ""
        txtAddress = ""
        txtCity = ""
        txtState = ""
        txtPostalCode = ""
        txtTypeName = "Home"
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
