//
//  FavoriteScene.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

struct FavoriteScene: View {
    @StateObject var vm=FavoriteViewModel()
    var body: some View {
        ZStack{
            ZStack{
                
                if(vm.listArr.count == 0) {
                    EmptyViews(text: "no data founded")
                }
                ScrollView{
                    LazyVStack {
                        ForEach (vm.listArr.indices, id: \.self) {
                            fObj in
                            
                            
//                            FavouriteRow(fObj: fObj)
                            ProductCell(vm:ExploreViewModel(),pObj: vm.listArr[fObj], isFull:true,didAddCart: {
                                vm.addToCart(prodId: vm.listArr[fObj].prodId ?? 1, qty: 1) { isDone, msg in
                                    
                                    self.vm.alertMsg = msg
                                    self.vm.alertError = true
                                }
                            })
                        }
                    }
                    .padding(20)
                    .padding(.top, .topInsets + 46)
                    .padding(.bottom, .bottomInsets + 60)
                    
                }
                
                
                VStack {
                    
                    HStack{
                        
                        Spacer()
                        
                        Text("Favorites")
                            .font(.customfont(.bold, fontSize: 20))
                            .frame(height: 46)
                        Spacer()
                        
                    }
                    .padding(.top, .topInsets)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.2),  radius: 2 )
                    
                    Spacer()
                    
//                    if vm.listArr.count > 0{
//                        CustomBTN(title: "Add All To Cart")
//                            .padding(.horizontal, 20)
//                            .padding(.bottom, .bottomInsets + 80)
//                    }
                }
                
                
                
            }
            .onAppear{
                vm.serviceCallList()
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


