//
//  LoginSceneViewModel.swift
//  Food App
//
//  Created by hosam on 06/07/2026.
//

import SwiftUI

class LoginSceneViewModel: ObservableObject {
    @AppStorage("isUserLogin") var isUserLogin: Bool = false

    @Published var isLoading=false
    @Published var alertMsg=""
    @Published var alert=false
        @Published var alertError=false
    
    @Published var emailLogin="a@a.com"
    @Published var passLogin="0000"
    @Published var isLogin=0

    @Published var emailSignup=""
    @Published var emailForget=""
    @Published var resetCode=""
    @Published var userId=0
    @Published var new_password=""

    

    @Published var username=""
    @Published var passSignup=""
    
    func getLogin() -> LoginPassModel {
        return .init(email: emailLogin, password: passLogin, dervice_token: "")
    }
    
    func getSignUp() -> SignupPassModel {
        return .init(username: username,email: emailLogin, password: passLogin, dervice_token: "")
    }
    func getForget() -> ForgetPassModel {
        return .init(email: emailForget)
    }
    func getForgetVerfiy() -> ForgetVerifyPassModel {
        if let code=Int(resetCode){
            return .init(email: emailForget, reset_code: code)
        }
        else{return .init(email: "", reset_code: 0)}
    }
    
    func getForgetVerfiySetPass() -> ForgetVerifySetPassPassModel {
        if let code=Int(resetCode){
            return .init(user_id:userId,new_password:new_password,reset_code:code)
        }else{return .init(user_id:0,new_password:"",reset_code:0)}
    }
    
    func forgetVerifySetPass()  {
        
        if  !Reachability.isConnectedToNetwork(){
        }else{
            withAnimation{isLoading.toggle()}
            
            Task
            {
                do {
                    
                    let login = getForgetVerfiySetPass()
                    
                    let res: LoginResModel = try         await FoodAPI().forget_verfiy_setPass(body: login)
                    
                    Task{@MainActor in
                        if let err=Int(res.status ?? "1"),err==0 {
                            self.serverError(message: res.message)
                        }else{
                            isLoading=false
                            self.isLogin=0
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
    
    func forgetVerify()  {
        if  !Reachability.isConnectedToNetwork(){
        }else{
            withAnimation{isLoading.toggle()}
            
            Task
            {
                do {
                    
                    let login = getForgetVerfiy()
                    
                    let res: LoginResModel = try         await FoodAPI().forget_verfiy(body: login)
                    
                    Task{@MainActor in
                        if let err=Int(res.status ?? "1"),err==0 {
                            self.serverError(message: res.message)
                        }else{
                            isLoading=false
                            if let code = res.payload?.reset_code{
                             resetCode=code
                                self.isLogin=4
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
    
    func forget()  {
        
//                if(!emailForget.isValidEmail) {
//                    self.alertMsg = "please enter valid email address"
//                    self.alertError = true
//                    return
//                }
                
                if  !Reachability.isConnectedToNetwork(){
                }else{
                    withAnimation{isLoading.toggle()}
                    
                    Task
                    {
                        do {
                            
                            let login = getForget()
                            
                            let res: LoginResModel = try         await FoodAPI().forget(body: login)
                            
                            Task{@MainActor in
                                if let err=Int(res.status ?? "1"),err==0 {
                                    self.serverError(message: res.message)
                                }else{
                                    isLoading=false
                                    self.isLogin=3
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
    
    func signUp()  {
//        if(username.isEmpty ) {
//            self.alertMsg = "please enter valid Username"
//            self.alertError = true
//            return
//        }
//        
//        if(!emailSignup.isValidEmail) {
//            self.alertMsg = "please enter valid email address"
//            self.alertError = true
//            return
//        }
//
//        if(passSignup.isEmpty ) {
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
                    
                    let login = getSignUp()
                    
                    
                    
                    let res: LoginResModel = try         await FoodAPI().signUp(body: login)
                    
                    Task{@MainActor in
                        if let err=Int(res.status ?? "1"),err==0 {
                            self.serverError(message: res.message)
                        }else{
                            isLoading=false
                            if let user=res.payload{
                                let cacheUser: LocalJSONStore<UserModel> = LocalJSONStore(storageType: .cache, filename: "UserModel.json")
                                cacheUser.save(user)
                                 isUserLogin = true

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

    
    func login()  {
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
                    
                    var login = getLogin()
                    
                    
                    
                    let res: LoginResModel = try         await FoodAPI().login(body: login)
                    
                    Task{@MainActor in
                        if let err=Int(res.status ?? "1"),err==0 {
                            self.serverError(message: res.message)
                        }else{
                            isLoading=false
                            if let user=res.payload{
                                let cacheUser: LocalJSONStore<UserModel> = LocalJSONStore(storageType: .cache, filename: "UserModel.json")
                                if let userId=user.user_id,userId > 0{
                                    cacheUser.save(user)
                                    
                                }else{
                                    let sec = UserModel(user_id: 8, id: 1, username: "username", name: "name", email: "a@a.com", mobile: "1001384592", mobileCode: "+2", authToken: user.authToken ?? "")
                                    cacheUser.save(sec)
                                }
                                
//                                cacheUser.save(user)
//                                cacheUser.save(sec)

                                isUserLogin = true
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
