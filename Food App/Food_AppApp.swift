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

    var body: some Scene {
        WindowGroup {
            NavigationView{
//                SignUpScene(vm: LoginSceneViewModel())
//                SignInScene()
                            LoginScene()
//                WelcomeScene()
                    .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
                
            }
        }
    }
}
