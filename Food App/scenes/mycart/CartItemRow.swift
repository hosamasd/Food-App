//
//  CartItemRow.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

struct CartItemRow: View {
    @State var cObj: CartItemModel = CartItemModel()
    @ObservedObject var vm:MyCartViewModel
    var body: some View {
        VStack{
            HStack(spacing: 15){
                CacheAsyncImage(
                    url: URL(string: cObj.image ?? "") ?? URL(fileURLWithPath: "")
                ) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
//                                .indicator(.activity) // Activity Indicator
//                                .transition(.fade(duration: 0.5))
                                .scaledToFit()
                                .frame(width: 60, height: 60)
                        @unknown default:
                            fatalError()
                        }
                    }
//                WebImage(url: URL(string: cObj.image ))
//                    .resizable()
//                    .indicator(.activity) // Activity Indicator
//                    .transition(.fade(duration: 0.5))
//                    .scaledToFit()
//                    .frame(width: 60, height: 60)
                
                
                VStack(spacing: 4){
                    
                    HStack {
                        Text(cObj.name ?? "")
                            .font(.customfont(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            vm.removeFromCart(cObj: cObj)
                        } label: {
                            Image("close")
                                .resizable()
                                .frame(width: 18, height: 18)
                        }
                        
                    }
                    
                    
                    Text("\(String(describing: cObj.unitValue))\(String(describing: cObj.unitName)), price")
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 8)
                    
                    
                    HStack{
                        if let qty=cObj.qty{
                            Button {
                                vm.UpdateQty(cObj: cObj, newQty: qty - 1)
                            } label: {
                                
                                Image( "subtack"  )
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .padding(10)
                            }
                            .padding(4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(  Color.placeholder.opacity(0.5), lineWidth: 1)
                            )
                        }
                        
                        Text( "\(String(describing: cObj.qty))" )
                            .font(.customfont(.bold, fontSize: 24))
                            .foregroundColor(.primaryText)
                            .multilineTextAlignment(.center)
                            .frame(width: 45, height: 45, alignment: .center)
                        
                        if let qty=cObj.qty{
                            Button {
                                vm.UpdateQty(cObj: cObj, newQty: qty + 1)
                            } label: {
                                
                                Image( "add_green"  )
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .padding(10)
                            }
                            .padding(4)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(  Color.placeholder.opacity(0.5), lineWidth: 1)
                            )
                        }
                        Spacer()
                        
                        Text("$\((cObj.offerPrice ?? cObj.price) ?? 0.0, specifier: "%.2f" )")
                            .font(.customfont(.semibold, fontSize: 20))
                            .foregroundColor(.primaryText)
                    }
                    
                }
                
                
                
            }
            Divider()
        }
    }
}
