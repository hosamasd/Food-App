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
                            
                            Text("Egypt, Cairo, Zagazig")
                                .font(.customfont(.semibold, fontSize: 18))
                                .foregroundColor(.darkGray)
                        }
                        
                        SearchTextField(placholder: "Search Store", txt: $vm.txtSearch)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .onChange(of: vm.txtSearch) { val in
                                if val.count > 0 {
                                    vm.listArrSearch =  vm.listArr.filter({$0.name!.lowercased().contains(val.lowercased())})
                                    vm.typeArrSearch =   vm.typeArr.filter({$0.type_name!.lowercased().contains(val.lowercased())})
                                    vm.bestArrSearch =  vm.bestArr.filter({$0.name!.lowercased().contains(val.lowercased())})
                                    vm.offerArrSearch = vm.offerArr.filter({$0.name!.lowercased().contains(val.lowercased())})
                                }else{
                                    vm.listArrSearch=vm.listArr
                                    vm.offerArrSearch=vm.offerArr
                                    vm.typeArrSearch=vm.typeArr
                                    vm.bestArrSearch = vm.bestArr
                                }
                            }
                    }
                    .padding(.top, .topInsets )
                    
                    Image("banner_top")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 115)
                        .padding(.horizontal, 20)
                    
                    if vm.offerArrSearch.count > 0{
                        NavigationLink {
                            SeeAllScene( vm: vm,title:"Exclusive offer",isBest:0,isCategory:false)
                        } label: {
                            SectionTitleAll(title: "Exclusive offer", titleAll: "See All") {
                                
                            }
                            .padding(.horizontal, 20)
                        }
                        ScrollView(.horizontal, showsIndicators: false ) {
                            LazyHStack(spacing: 15) {
                                ForEach (vm.offerArrSearch.indices, id: \.self) {
                                    pObj in
                                    
                                    ProductCell(vm:ExploreViewModel(),pObj: vm.offerArrSearch[pObj], didAddCart: {
                                        
                                        vm.addToCart(prodId: vm.offerArrSearch[pObj].prodId ?? 1 , qty: 1) { isDone, msg in
                                            
                                            self.vm.alertMsg = msg
                                            self.vm.alertError = true
                                        }
                                    })
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 4)
                        }
                    }
                    
                    if vm.bestArrSearch.count > 0{
                        NavigationLink {
                            SeeAllScene( vm: vm,title:"Best Selling",isBest:1,isCategory:false)
                        } label: {
                            SectionTitleAll(title: "Best Selling", titleAll: "See All") {
                                
                            }
                            .padding(.horizontal, 20)
                        }
                        ScrollView(.horizontal, showsIndicators: false ) {
                            LazyHStack(spacing: 15) {
                                ForEach (vm.bestArrSearch.indices, id: \.self) {
                                    pObj in
                                    
                                    ProductCell(vm:ExploreViewModel(),pObj: vm.bestArrSearch[pObj], didAddCart: {
                                        vm.addToCart(prodId: vm.bestArrSearch[pObj].prodId ?? 1, qty: 1) { isDone, msg in
                                            
                                            self.vm.alertMsg = msg
                                            self.vm.alertError = true
                                        }
                                    })
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 4)
                        }
                    }
                    
                    if vm.typeArrSearch.count > 0{
                        NavigationLink {
                            SeeAllScene( vm: vm,title:"Groceries",isBest:0,isCategory:true)
                        } label: {
                            SectionTitleAll(title: "Groceries", titleAll: "See All") {
                                
                            }
                            .padding(.horizontal, 20)
                        }
                        ScrollView(.horizontal, showsIndicators: false ) {
                            LazyHStack(spacing: 15) {
                                
                                ForEach (vm.typeArrSearch.indices, id: \.self) {
                                    tObj in
                                    
                                    CategoryCell(tObj: vm.typeArrSearch[tObj]) {
                                        
                                    }
                                }
                                
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 4)
                        }
                        .padding(.bottom, 8)
                    }
                    
                    if vm.listArrSearch.count > 0{
                        NavigationLink {
                            SeeAllScene( vm: vm,title:"Cocktail",isBest:3,isCategory:false)
                        } label: {
                            SectionTitleAll(title: "Cocktail", titleAll: "See All") {
                                
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false ) {
                            LazyHStack(spacing: 15) {
                                ForEach (vm.listArrSearch.indices, id: \.self) {
                                    pObj in
                                    
                                    ProductCell(vm:ExploreViewModel(),pObj: vm.listArrSearch[pObj], didAddCart: {
                                        vm.addToCart(prodId: vm.listArrSearch[pObj].prodId ?? 1, qty: 1) { isDone, msg in
                                            
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
