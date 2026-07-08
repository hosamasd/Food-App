//
//  Food_AppApp.swift
//  Food App
//
//  Created by hosam on 06/07/2026.
//

import SwiftUI

@main
struct Food_AppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @AppStorage("isUserLogin") var isUserLogin: Bool = false

    var body: some Scene {
        WindowGroup {
            NavigationView{
                
                if isUserLogin{
                    MainTabScene()
                }else{
                    WelcomeScene()
                }
                
//                DelieryAddressView()
                
//                SignUpScene(vm: LoginSceneViewModel())
//                SignInScene()
//                AccountScene()
//                MainTabScene()
//                            LoginScene()
//                WelcomeScene()
                    
                
            }
            .onAppear(perform: {
                UIApplication.shared.addTapGestureRecognizer()
//             isUserLogin=false
            })
        }
        
    }
}
