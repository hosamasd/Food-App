//
//  AccountScene.swift
//  Food App
//
//  Created by hosam on 06/07/2026.
//

import SwiftUI

struct AccountScene: View {
    @StateObject var vm=AccountViewModel()
    
    var body: some View {
        ZStack{
            VStack{
                
                HStack(spacing: 15) {
                    Image("u1")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .cornerRadius(30)
                    
                    VStack{
                        
                        HStack{
                            Text("Code For iOS")
                                .font(.customfont(.bold, fontSize: 20))
                                .foregroundStyle(Color.primaryText)
                            
                            Image(systemName: "pencil")
                                .foregroundStyle(Color.primaryApp)
                                .onTapGesture {
                                    vm.isHome=false
                                }
                            
                            Spacer()
                        }
                        
                        Text(vm.currentUser.email ?? "")
                            .font(.customfont(.regular, fontSize: 16))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading )
                            .accentColor(.secondaryText)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, .topInsets)
                
                Divider()
                
                ZStack{
                    ScrollView {
                        LazyVStack {
                            
                            VStack{
                                
                                NavigationLink {
                                    MyOrdersView()
                                } label: {
                                    AccountRow(title: "My Orders", icon: "a_order")
                                }
                                
                                
                                //                                                            NavigationLink {
                                //                                                                MyDetailsView(vm:vm)
                                //                                                            } label: {
                                //                                                                AccountRow(title: "My Details", icon: "a_my_detail")
                                //                                                            }
                                
                                Button {
                                    vm.isHome=false
                                } label: {
                                    AccountRow(title: "My Details", icon: "a_my_detail")
                                }
                                
                                
                                
                                NavigationLink {
                                    DelieryAddressView()
                                } label: {
                                    AccountRow(title: "Delivery Address", icon: "a_delivery_address")
                                }
                                
                                
                                NavigationLink {
                                    PaymentMethodsView()
                                } label: {
                                    AccountRow(title: "Payment Methods", icon: "paymenth_methods")
                                }
                                
                                NavigationLink {
                                    PromoCodeView()
                                } label: {
                                    AccountRow(title: "Promo Code", icon: "a_promocode")
                                }
                            }
                            VStack{
                                NavigationLink {
                                    NotificationView(vm: vm)
                                } label: {
                                    AccountRow(title: "Notifications", icon: "a_noitification")
                                }
                                
                                AccountRow(title: "Help", icon: "a_help")
                                AccountRow(title: "About", icon: "a_about")
                            }
                            
                            Button {
                                vm.logout()
                            } label: {
                                ZStack {
                                    Text("Log Out")
                                        .font(.customfont(.semibold, fontSize: 18))
                                        .foregroundColor(.primaryApp)
                                        .multilineTextAlignment(.center)
                                    
                                    HStack{
                                        Spacer()
                                        Image("logout")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                            .padding(.trailing, 20)
                                    }
                                }
                                
                            }
                            .frame( minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60 )
                            .background( Color(hex: "F2F3F2"))
                            .cornerRadius(20)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                            
                        }
                        
                    }
                    .opacity(vm.isHome ? 1 : 0)
                    
                    if !vm.isHome{
                        MyDetailsView(vm: vm)
                            .transition(.move(edge: .leading))
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
            content: { Alert(title: Text(LocalizedStringKey(vm.alertMsg))) })
    }
}

#Preview {
    AccountScene()
}
