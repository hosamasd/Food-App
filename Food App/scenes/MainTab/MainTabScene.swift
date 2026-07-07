//
//  MainTabScene.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

struct MainTabScene: View {
    @StateObject var vm=HomeViewModel()
    var body: some View {
        ZStack{
            
            if(vm.selectTab == 0) {
//                HomeView()
                AccountScene()
            }else if(vm.selectTab == 1) {
                ExploreScene()
//                AccountScene()
            }else if(vm.selectTab == 2) {
                MyCartScene()
            }else if(vm.selectTab == 3) {
                FavoriteScene()
//                AccountScene()
            }else if(vm.selectTab == 4) {
                AccountScene()
            }
            
            VStack{
                
                Spacer()
                
                HStack{
                    
                    TabButton(title: "Shop", icon: "store_tab", isSelect: vm.selectTab == 0) {
                        
                        print("Button Tab")
                        
                        DispatchQueue.main.async {
                             
                            withAnimation {
                                vm.selectTab = 0
                            }
                        }
                        
                       
                    }
                    TabButton(title: "Explore", icon: "explore_tab", isSelect: vm.selectTab == 1) {
                        DispatchQueue.main.async {
                             
                            withAnimation {
                                vm.selectTab = 1
                            }
                        }
                    }
                    
                    TabButton(title: "Cart", icon: "cart_tab", isSelect: vm.selectTab == 2) {
                        DispatchQueue.main.async {
                             
                            withAnimation {
                                vm.selectTab = 2
                            }
                        }
                    }
                    
                    TabButton(title: "Favourite", icon: "fav_tab", isSelect: vm.selectTab == 3) {
                        DispatchQueue.main.async {
                             
                            withAnimation {
                                vm.selectTab = 3
                            }
                        }
                    }
                    
                    TabButton(title: "Account", icon: "account_tab", isSelect: vm.selectTab == 4) {
                        DispatchQueue.main.async {
                             
                            withAnimation {
                                vm.selectTab = 4
                            }
                        }
                    }
                    
                                    
                }
                .padding(.top, 10)
                .padding(.bottom, .bottomInsets)
                .padding(.horizontal, 10)
                .background(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.black.opacity(0.15), radius: 3, x: 0, y: -2)
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}

#Preview {
    MainTabScene()
}
