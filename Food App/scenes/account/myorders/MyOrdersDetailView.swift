//
//  MyOrdersDetailView.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

struct MyOrdersDetailView: View {
    let prodObj:MyOrderModel
    @ObservedObject var vm:MyOrdersViewModel
    @State var showWriteReview = false

    var body: some View {
        ZStack{
            ZStack{
                ScrollView {
                    
                    VStack{
                        HStack{
                            Text("Order ID: # \( String(describing: prodObj.id) )")
                                .font(.customfont(.bold, fontSize: 20))
                                .foregroundColor(.primaryText)
                            
                            Spacer()
                            
                            Text( getPaymentStatus(mObj: prodObj )  )
                                .font(.customfont(.bold, fontSize: 18))
                                .foregroundColor( getPaymentStatusColor(mObj: prodObj))
                        }
                        
                        
                        HStack{
                            Text(prodObj.createdDate?.displayDate(format: "yyyy-MM-dd hh:mm a") ?? "")
                                .font(.customfont(.regular, fontSize: 12))
                                .foregroundColor(.secondaryText)
                            
                            Spacer()
                            
                            Text( getOrderStatus(mObj: prodObj )  )
                                .font(.customfont(.bold, fontSize: 18))
                                .foregroundColor( getOrderStatusColor(mObj: prodObj))
                        }
                        .padding(.bottom, 8)
                        
                        Text("\(String(describing: prodObj.address)),\(String(describing: prodObj.city)), \(String(describing: prodObj.state)), \(String(describing: prodObj.postalCode)) ")
                            .font(.customfont(.regular, fontSize: 16))
                            .foregroundColor(.secondaryText)
                            .multilineTextAlignment( .leading)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 8)
                        
                        HStack{
                            Text("Delivery Type:")
                                .font(.customfont(.medium, fontSize: 16))
                                .foregroundColor(.primaryText)
                            
                            Spacer()
                            
                            Text( getDeliveryType(mObj: prodObj )  )
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor( .primaryText )
                        }
                        .padding(.bottom, 4)
                        
                        HStack{
                            Text("Payment Type:")
                                .font(.customfont(.medium, fontSize: 16))
                                .foregroundColor(.primaryText)
                            
                            Spacer()
                            
                            Text( getPaymentType(mObj: prodObj )  )
                                .font(.customfont(.regular, fontSize: 16))
                                .foregroundColor( .primaryText )
                        }
                        
                        
                    }
                    .padding(15)
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.15), radius: 2)
                    .padding(.horizontal, 20)
                    .padding(.top, .topInsets + 46)
                    
//                    LazyVStack {
//                        ForEach(detailVM.listArr, id: \.id) { pObj in
//                            OrderItemRow(pObj: pObj, showReviewBotton: prodObj.orderStatus == 3 && pObj.rating == 0) {
//                                showWriteReview = true
//                            }
//                        }
//                    }
                    
                    VStack{
                                           
                        HStack{
                            Text("Amount:")
                                .font(.customfont(.bold, fontSize: 18))
                                .foregroundColor(.primaryText)
                            
                            Spacer()
                            
                            Text( "$\( prodObj.totalPrice ?? 0.0, specifier: "%.2f" )"  )
                                .font(.customfont(.medium, fontSize: 18))
                                .foregroundColor( .primaryText )
                        }
                        .padding(.bottom, 4)
                        
                        HStack{
                            Text("Delivery Cost:")
                                .font(.customfont(.bold, fontSize: 18))
                                .foregroundColor(.primaryText)
                            
                            Spacer()
                            
                            Text( "+ $\( prodObj.deliverPrice ?? 0.0, specifier: "%.2f" )"  )
                                .font(.customfont(.medium, fontSize: 18))
                                .foregroundColor( .primaryText )
                        }
                        .padding(.bottom, 4)
                        
                        HStack{
                            Text("Discount Cost:")
                                .font(.customfont(.bold, fontSize: 18))
                                .foregroundColor(.primaryText)
                            
                            Spacer()
                            
                            Text( "- $\( prodObj.discountPrice ?? 0.0, specifier: "%.2f" )"  )
                                .font(.customfont(.medium, fontSize: 18))
                                .foregroundColor( .red )
                        }
                        .padding(.bottom, 4)
                        
                        Divider()
                        
                        HStack{
                            Text("Total:")
                                .font(.customfont(.bold, fontSize: 22))
                                .foregroundColor(.primaryText)
                            
                            Spacer()
                            
                            Text( "$\( prodObj.userPayPrice ?? 0.0, specifier: "%.2f" )"  )
                                .font(.customfont(.bold, fontSize: 22))
                                .foregroundColor( .primaryText )
                        }
                        .padding(.bottom, 4)
                        
                        
                    }
                    .padding(15)
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(color: Color.black.opacity(0.15), radius: 2)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 4)
                    
                }
                
                TopHeaderView(title: "My Order Detail")
            }
            
            if vm.isLoading{
                ArcView()
            }
        }
        .onAppear {
            vm.getOrderById(id: prodObj.id ?? 1)
        }
        .background( NavigationLink(destination: WriteReviewView(), isActive: $showWriteReview, label: {
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

extension MyOrdersDetailView{
    func getOrderStatus(mObj: MyOrderModel) -> String {
        switch mObj.orderStatus {
        case 1:
            return "Placed"
        case 2:
            return "Accepted";
        case 3:
            return "Delivered";
        case 4:
            return "Cancel";
        case 5:
            return "Declined";
        default:
            return "";
        }
    }
    
    func getDeliveryType(mObj: MyOrderModel) -> String {
        switch mObj.deliverType {
        case 1:
              return "Delivery";
            case 2:
              return "Collection";
        default:
            return "";
        }
    }
    
    func getPaymentType(mObj: MyOrderModel) -> String {
        switch mObj.paymentType {
        case 1:
            return "Cash On Delivery";
        case 2:
            return "Online Card Payment";
        default:
            return "";
        }
    }
    
    func getPaymentStatus(mObj: MyOrderModel) -> String {
        switch mObj.paymentStatus {
        case 1:
            return "Processing";
        case 2:
            return "Success";
        case 3:
            return "Fail";
        case 4:
            return "Refunded";
        default:
            return "";
        }
    }
    
    func getPaymentStatusColor(mObj: MyOrderModel) -> Color {
        
        if (mObj.paymentType == 1) {
            return Color.orange;
        }
        
        switch mObj.paymentStatus {
        case 1:
            return Color.blue;
        case 2:
            return Color.green;
        case 3:
            return Color.red;
        case 4:
            return Color.green;
        default:
            return Color.white;
        }
    }
    
    func getOrderStatusColor(mObj: MyOrderModel) -> Color {
      switch mObj.orderStatus {
        case 1:
              return Color.blue;
            case 2:
              return Color.green;
            case 3:
              return Color.green;
            case 4:
              return Color.red;
            case 5:
              return Color.red;
            default:
              return Color.primaryApp;        }
    }
}

