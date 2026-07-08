//
//  MyOrderCellView.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

struct MyOrderCellView: View {
    let myObj:MyOrderModel
    
    var body: some View {
        VStack{
            HStack {
                
                Text("Order No: #")
                    .font(.customfont(.bold, fontSize: 16))
                    .foregroundColor(.primaryText)
                
                
                Text("\( String(describing: myObj.id)  )")
                    .font(.customfont(.bold, fontSize: 14))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                
                Text(getOrderStatus(mObj: myObj))
                    .font(.customfont(.bold, fontSize: 16))
                    .foregroundColor( getOrderStatusColor(mObj: myObj) )
                
            }
            
            Text(myObj.createdDate?.displayDate(format: "yyyy-MM-dd hh:mm a") ?? "")
                .font(.customfont(.bold, fontSize: 12))
                .foregroundColor(.secondaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            
            
            HStack {
                
                if let imgageUrl = myObj.images?.first {
                    CacheAsyncImage(
                        url: URL(string: imgageUrl ) ?? URL(fileURLWithPath: "")
                    ) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
//                                .indicator(.activity)
//                                .transition(.fade(duration: 0.5))
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                        @unknown default:
                            fatalError()
                        }
                        }
                    }
                
                
                VStack{
                    HStack {
                        
                        Text("Items:")
                            .font(.customfont(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        
                        Text(myObj.names ?? "")
                            .font(.customfont(.medium, fontSize: 14))
                            .foregroundColor(.secondaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                    }
                    
                    HStack {
                        
                        Text("Delivery Type:")
                            .font(.customfont(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        
                        Text( self.getDeliveryType(mObj: myObj) )
                            .font(.customfont(.medium, fontSize: 14))
                            .foregroundColor(.secondaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                    }
                    
                    HStack {
                        
                        Text("Payment Type:")
                            .font(.customfont(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        
                        Text(getPaymentType(mObj: myObj))
                            .font(.customfont(.medium, fontSize: 14))
                            .foregroundColor(.secondaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                    }
                    
                    HStack {
                        
                        Text("Payment Status:")
                            .font(.customfont(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        
                        Text( getPaymentStatus(mObj: myObj))
                            .font(.customfont(.medium, fontSize: 14))
                            .foregroundColor( getPaymentStatusColor(mObj: myObj))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                    }
                    
                }
                
            }
            
        }
    }
    
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

