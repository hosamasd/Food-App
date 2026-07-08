//
//  CheckoutView.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

struct CheckoutView: View {
    @Binding var isShow: Bool
    @ObservedObject var vm:MyCartViewModel

    var body: some View {
        ScrollView(isSmallDevice() ? .vertical : .init()){
            ZStack{
                VStack {
                    
                    Spacer()
                    VStack{
                        HStack{
                            
                            Text("Checkout")
                                .font(.customfont(.bold, fontSize: 20))
                                .frame(height: 46)
                            Spacer()
                            
                            Button {
                                $isShow.wrappedValue = false
                            } label: {
                                Image("close")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                            }
                            
                            
                        }
                        .padding(.top, 30)
                        
                        Divider()
                        
                        
                        VStack{
                            HStack {
                                Text("Delivery Type")
                                    .font(.customfont(.semibold, fontSize: 18))
                                    .foregroundColor(.secondaryText)
                                    .frame(height: 46)
                                
                                Spacer()
                                
                                Picker("",  selection: $vm.deliveryType) {
                                    Text("Delivery").tag(1)
                                    Text("Collection").tag(2)
                                }
                                .pickerStyle(.segmented)
                                .frame(width: 180)
                            }
                            
                            Divider()
                            
                            if(vm.deliveryType == 1) {
                                
                                NavigationLink {
                                    DelieryAddressView(isPicker: true, didSelect: {
                                        aObj in
                                        vm.deliverObj = aObj
                                    } )
                                } label: {
                                    HStack {
                                        Text("Delivery")
                                            .font(.customfont(.semibold, fontSize: 18))
                                            .foregroundColor(.secondaryText)
                                            .frame(height: 46)
                                        
                                        Spacer()
                                        
                                        Text( vm.deliverObj?.name ?? "Select Method")
                                            .font(.customfont(.semibold, fontSize: 18))
                                            .foregroundColor(.primaryText)
                                            .frame(height: 46)
                                        
                                        Image("next")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.primaryText)
                                        
                                    }
                                }
                                
                                
                                
                                Divider()
                            }
                            
                            
                            HStack {
                                Text("Payment Type")
                                    .font(.customfont(.semibold, fontSize: 18))
                                    .foregroundColor(.secondaryText)
                                    .frame(height: 46)
                                
                                Spacer()
                                
                                Picker("",  selection: $vm.paymentType) {
                                    Text("COD").tag(1)
                                    Text("Online").tag(2)
                                }
                                .pickerStyle(.segmented)
                                .frame(width: 150)
                            }
                            
                            Divider()
                            if(vm.paymentType == 2) {
                                
                                NavigationLink {
                                    PaymentMethodsView(isPicker: true, didSelect: {
                                        pObj in
                                        vm.paymentObj = pObj
                                    } )
                                } label: {
                                    HStack {
                                        Text("Payment")
                                            .font(.customfont(.semibold, fontSize: 18))
                                            .foregroundColor(.secondaryText)
                                            .frame(height: 46)
                                        
                                        Spacer()
                                        
                                        Image("master")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30, height: 20)
                                        
                                        Text( vm.paymentObj?.cardNumber ?? "Select")
                                            .font(.customfont(.semibold, fontSize: 18))
                                            .foregroundColor(.primaryText)
                                            .frame(height: 46)
                                        
                                        Image("next")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.primaryText)
                                        
                                    }
                                }
                                
                                Divider()
                            }
                            
                            NavigationLink {
                                PromoCodeView(isPicker: true, didSelect: {
                                    pObj in
                                    vm.promoObj = pObj
                                })
                            } label: {
                                HStack {
                                    Text("Promo Code")
                                        .font(.customfont(.semibold, fontSize: 18))
                                        .foregroundColor(.secondaryText)
                                        .frame(height: 46)
                                    
                                    Spacer()
                                    
                                    
                                    
                                    Text( vm.promoObj?.code  ?? "Pick Discount")
                                        .font(.customfont(.semibold, fontSize: 18))
                                        .foregroundColor(.primaryText)
                                        .frame(height: 46)
                                    
                                    Image("next")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.primaryText)
                                    
                                }
                            }
                            
                            Divider()
                        }
                        
                        VStack{
                            HStack {
                                Text("Totat")
                                    .font(.customfont(.semibold, fontSize: 16))
                                    .foregroundColor(.secondaryText)
                                
                                Spacer()
                                
                                Text("$ \(vm.total)")
                                    .font(.customfont(.semibold, fontSize: 16))
                                    .foregroundColor(.secondaryText)
                            }
                            
                            HStack {
                                Text("Delivery Cost")
                                    .font(.customfont(.semibold, fontSize: 16))
                                    .foregroundColor(.secondaryText)
                                
                                Spacer()
                                
                                Text("+ $ \(vm.deliverPriceAmount)")
                                    .font(.customfont(.semibold, fontSize: 16))
                                    .foregroundColor(.secondaryText)
                            }
                            
                            HStack {
                                Text("Discount")
                                    .font(.customfont(.semibold, fontSize: 16))
                                    .foregroundColor(.secondaryText)
                                
                                Spacer()
                                
                                Text("- $ \(vm.discountAmount)")
                                    .font(.customfont(.semibold, fontSize: 16))
                                    .foregroundColor(.red)
                            }
                            
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 15)
                        
                        HStack {
                            Text("Final Total")
                                .font(.customfont(.semibold, fontSize: 18))
                                .foregroundColor(.secondaryText)
                                .frame(height: 46)
                            
                            Spacer()
                            
                            
                            
                            Text("$\(vm.userPayAmount)")
                                .font(.customfont(.semibold, fontSize: 18))
                                .foregroundColor(.primaryText)
                                .frame(height: 46)
                            
                            Image("next")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.primaryText)
                            
                        }
                        Divider()
                        
                        VStack {
                            Text("By continuing you agree to our")
                                .font(.customfont(.semibold, fontSize: 14))
                                .foregroundColor(.secondaryText)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            HStack{
                                
                                Text("Terms of Service")
                                    .font(.customfont(.semibold, fontSize: 14))
                                    .foregroundColor(.primaryText)
                                
                                
                                Text(" and ")
                                    .font(.customfont(.semibold, fontSize: 14))
                                    .foregroundColor(.secondaryText)
                                
                                
                                Text("Privacy Policy.")
                                    .font(.customfont(.semibold, fontSize: 14))
                                    .foregroundColor(.primaryText)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                            }
                            
                        }
                        .padding(.vertical, .screenWidth * 0.03)
                        
                        CustomBTN(title: "Place Order") {
                            vm.orderPlace()
                        }
                        .padding(.bottom, .bottomInsets + 70)
                    }
                    
                    
                    .padding(.horizontal, 20)
                    .background(Color.white)
                    .cornerRadius(20, corner: [.topLeft, .topRight])
                }
                if vm.isLoading{
                    ArcView()
                }
            }
        }
        .padding(.bottom)
    }
}
