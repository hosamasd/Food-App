//
//  LoginSceneViewModel.swift
//  Food App
//
//  Created by hosam on 06/07/2026.
//

import SwiftUI

class LoginSceneViewModel: ObservableObject {
    @Published var isLoading=false
    @Published var alertMsg=""
    @Published var alert=false

    
    @Published var alertError=false
    
    @Published var emailLogin=""
    @Published var passLogin=""
    @Published var isLogin=true

    @Published var emailSignup=""
    @Published var username=""
    @Published var passSignup=""
    
    func getLogin() -> LoginPassModel {
        return .init(email: emailLogin, password: passLogin, dervice_token: "")
    }
    
    func getSignUp() -> SignupPassModel {
        return .init(username: username,email: emailLogin, password: passLogin, dervice_token: "")
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
