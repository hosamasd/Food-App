//
//  AccountViewModel.swift
//  Food App
//
//  Created by hosam on 06/07/2026.
//

import SwiftUI

class AccountViewModel: ObservableObject {
    @Published var currentUser=UserModel()
    @AppStorage("isUserLogin") var isUserLogin: Bool = false
    @Published var isLoading=false
    @Published var alertMsg=""
    @Published var alert=false
        @Published var alertError=false
    @Published var isHome=true

    
    @Published var listArrNotification: [NotificationModel] = []

    
    init() {
        let cacheUser: LocalJSONStore<UserModel> = LocalJSONStore(storageType: .cache, filename: "UserModel.json")
        let sec = UserModel(user_id: 8, id: 1, username: "username", name: "name", email: "a@a.com", mobile: "1001384592", mobileCode: "+2", authToken: "8F9WIG9MwqcTJkpkRXrP")
        
//                                cacheUser.save(user)
//        cacheUser.save(sec)
        currentUser=sec//cacheUser.storedValue ?? UserModel()

//        currentUser=cacheUser.storedValue ?? UserModel()
    }
    
    func logout()  {
        let cacheUser: LocalJSONStore<UserModel> = LocalJSONStore(storageType: .cache, filename: "UserModel.json")
        cacheUser.deleteFile(cacheUser.storedValue ?? UserModel())
        isUserLogin=false
    }
    
    func getUpdate(name:String,username:String,mobile:String,mobile_code:String) -> UpdateProfilePassModel {
        return .init(username: username, name: name, mobile: mobile, mobile_code: mobile_code)
    }
    
    func getAllNotification()  {
        if  !Reachability.isConnectedToNetwork(){
        }else{
            withAnimation{isLoading.toggle()}
            
            Task
            {
                do {
                    
                    let res: NotificationResModel = try         await FoodAPI().getAllNotification()
                    
                    Task{@MainActor in
                        if let err=Int(res.status ?? "0"),err==0 {
                            self.serverError(message: res.message)
                        }else{
                            isLoading=false
                            if let arr=res.payload{
                                listArrNotification=arr
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

    
    func readAllNotifications()  {
        if  !Reachability.isConnectedToNetwork(){
        }else{
            withAnimation{isLoading.toggle()}
            
            Task
            {
                do {
                    
                    let res: LoginResModel = try         await FoodAPI().readAllNotification()
                    
                    Task{@MainActor in
                        if let err=Int(res.status ?? "0"),err==0 {
                            self.serverError(message: res.message)
                        }else{
                           getAllNotification()
                            
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
    
    func update(name:String,username:String,mobile:String,mobile_code:String)  {
    //        if(!emailLogin.isValidEmail) {
    //            self.alertMsg = "please enter valid email address"
    //            self.alertError = true
    //            return
    //        }
    //
    //        if(passLogin.isEmpty ) {
    //            self.alertMsg = "please enter valid password"
    //            self.alertError = true
    //            return
    //        }
            
            if  !Reachability.isConnectedToNetwork(){
            }else{
                withAnimation{isLoading.toggle()}
                
                Task
                {
                    do {
                        
                        var login = getUpdate(name:name,username:username,mobile: mobile,mobile_code: mobile_code)
                        
                        
                        
                        let res: LoginResModel = try         await FoodAPI().updateProfile(body: login)
                        
                        Task{@MainActor in
                            if let err=Int(res.status ?? "0"),err==0 {
                                self.serverError(message: res.message)
                            }else{
                                isLoading=false
                                if let user=res.payload{
                                    let cacheUser: LocalJSONStore<UserModel> = LocalJSONStore(storageType: .cache, filename: "UserModel.json")
                                    cacheUser.save(user)
                                    isHome=true
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
