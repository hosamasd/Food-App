//
//  HomeScene.swift
//  Food App
//
//  Created by hosam on 08/07/2026.
//

import SwiftUI

struct HomeScene: View {
    @StateObject var vm=HomeViewModel()
    
    var body: some View {
        ZStack{
            ZStack{
                ScrollView{
                    VStack{
                        Image("color_logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                        
                        HStack{
                            Image("location")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 16, height: 16 )
                            
                            Text("Dhaka, Banassre")
                                .font(.customfont(.semibold, fontSize: 18))
                                .foregroundColor(.darkGray)
                        }
                        
                        SearchTextField(placholder: "Search Store", txt: $vm.txtSearch)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                    }
                    .padding(.top, .topInsets )
                    
                    Image("banner_top")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 115)
                        .padding(.horizontal, 20)
                    
                    SectionTitleAll(title: "Exclusive offer", titleAll: "See All") {
                        
                    }
                    .padding(.horizontal, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false ) {
                        LazyHStack(spacing: 15) {
                            ForEach (vm.offerArr, id: \.id) {
                                pObj in
                                
                                ProductCell(vm:ExploreViewModel(),pObj: pObj, didAddCart: {
                                    
                                    vm.addToCart(prodId: pObj.prodId ?? 1 , qty: 1) { isDone, msg in
                                        
                                        self.vm.alertMsg = msg
                                        self.vm.alertError = true
                                    }
                                })
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 4)
                    }
                    
                    
                    SectionTitleAll(title: "Best Selling", titleAll: "See All") {
                        
                    }
                    .padding(.horizontal, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false ) {
                        LazyHStack(spacing: 15) {
                            ForEach (vm.bestArr, id: \.id) {
                                pObj in
                                
                                ProductCell(vm:ExploreViewModel(),pObj: pObj, didAddCart: {
                                    vm.addToCart(prodId: pObj.prodId ?? 1, qty: 1) { isDone, msg in
                                        
                                        self.vm.alertMsg = msg
                                        self.vm.alertError = true
                                    }
                                })
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 4)
                    }
                    
                    SectionTitleAll(title: "Groceries", titleAll: "See All") {
                        
                    }
                    .padding(.horizontal, 20)
                    
                    ScrollView(.horizontal, showsIndicators: false ) {
                        LazyHStack(spacing: 15) {
                            ForEach (vm.typeArr, id: \.id) {
                                tObj in
                                
                                CategoryCell(tObj: tObj) {
                                    
                                }
                            }
                            
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 4)
                    }
                    .padding(.bottom, 8)
                    
                    ScrollView(.horizontal, showsIndicators: false ) {
                        LazyHStack(spacing: 15) {
                            ForEach (vm.listArr, id: \.id) {
                                pObj in
                                
                                ProductCell(vm:ExploreViewModel(),pObj: pObj, didAddCart: {
                                    vm.addToCart(prodId: pObj.prodId ?? 1, qty: 1) { isDone, msg in
                                        
                                        self.vm.alertMsg = msg
                                        self.vm.alertError = true
                                    }
                                })
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 4)
                    }
                    .padding(.bottom, .bottomInsets + 60)
                    
                }
            }
            if vm.isLoading{
                ArcView()
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        .overlay(overlayView: Toasts.init(dataModel: Toasts.ToastDataModel.init(title: vm.alertMsg, image: "checkmark"), show: $vm.alert)
                 , show: $vm.alert)
        .alert(
            isPresented: $vm.alertError,
            content: { Alert(title: Text(LocalizedStringKey(vm.alertMsg)))
            })
    }
}
