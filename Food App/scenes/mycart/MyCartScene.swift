//
//  MyCartScene.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

struct MyCartScene: View {
    @StateObject var vm=MyCartViewModel()
    
    var body: some View {
        ZStack{
            
            ZStack{
                if(vm.listArr.count == 0) {
                    EmptyView()
                }
                
                ScrollView{
                    LazyVStack {
                        ForEach( vm.listArr , id: \.id, content: {
                            cObj in
                            
                            CartItemRow(cObj: cObj,vm:vm)
                            
                        })
                        .padding(.vertical, 8)
                    }
                    .padding(20)
                    .padding(.top, .topInsets + 46)
                    .padding(.bottom, .bottomInsets + 60)
                    
                }
                
                VStack {
                    
                    HStack{
                        
                        Spacer()
                        
                        Text("My Cart")
                            .font(.customfont(.bold, fontSize: 20))
                            .frame(height: 46)
                        Spacer()
                        
                    }
                    .padding(.top, .topInsets)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.2),  radius: 2 )
                    
                    Spacer()
                    
                    if(vm.listArr.count > 0) {
                        Button {
                            vm.showCheckout = true
                        } label: {
                            ZStack {
                                Text("Check Out")
                                    .font(.customfont(.semibold, fontSize: 18))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                
                                HStack {
                                    Spacer()
                                    Text("$\(vm.total)")
                                        .font(.customfont(.semibold, fontSize: 12))
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color.darkGray.opacity(0.2))
                                        .cornerRadius(5)
                                }
                                .padding(.trailing)
                            }
                            
                        }
                        .frame( minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60 )
                        .background( Color.primaryApp)
                        .cornerRadius(20)
                        .padding(.horizontal, 20)
                        .padding(.bottom, .bottomInsets + 80)
                        
                        
                    }
                    
                }
                if(vm.showCheckout) {
                    Color.black
                        .opacity(0.3)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation {
                                vm.showCheckout = false
                            }
                        }
                    
//                    CheckoutView(isShow: $vm.showCheckout, vm: vm )
//                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                }
            }
            
            if vm.isLoading{
                ArcView()
            }
        }
        .onAppear{
            vm.serviceCallList()
        }
        .background( NavigationLink(destination: OrderAccpetView(), isActive: $vm.showOrderAccept  , label: {
            EmptyView()
        }) )
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
        .overlay(overlayView: Toasts.init(dataModel: Toasts.ToastDataModel.init(title: vm.alertMsg, image: "checkmark"), show: $vm.alert)
                 , show: $vm.alert)
        .alert(
            isPresented: $vm.alertError,
            content: { Alert(title: Text(LocalizedStringKey(vm.alertMsg))) })
        }
    
}

