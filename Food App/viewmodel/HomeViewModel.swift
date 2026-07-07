//
//  HomeViewModel.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var isLoading=false
    @Published var alertMsg=""
    @Published var alert=false
        @Published var alertError=false
    @Published var selectTab: Int = 0

    
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
