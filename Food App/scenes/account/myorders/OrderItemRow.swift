//
//  OrderItemRow.swift
//  Food App
//
//  Created by hosam on 08/07/2026.
//

import SwiftUI

struct OrderItemRow: View {
     var pObj: CartList
    var showReviewBotton = false
    var didTap: ( ()->() )?
    
    var body: some View {
            
        VStack {
            
       
            HStack(spacing: 15){
                CacheAsyncImage(
                    url: URL(string: pObj.image ?? "") ?? URL(fileURLWithPath: "")
                ) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                                            .frame(width: 60, height: 60)

                    @unknown default:
                        fatalError()
                    }
                }
//                WebImage(url: URL(string: pObj.image ))
//                    .resizable()
//                    .indicator(.activity) // Activity Indicator
//                    .transition(.fade(duration: 0.5))
//                    .scaledToFit()
//                    .frame(width: 60, height: 60)
                
                VStack(spacing: 4){
                    
                    Text(pObj.name ?? "")
                        .font(.customfont(.bold, fontSize: 16))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    if let unitValue=pObj.unitValue, let unitName=pObj.unitName{
                        Text(unitValue+unitName+", price")
                            .font(.customfont(.medium, fontSize: 14))
                            .foregroundColor(.secondaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 8)
                    }
                    
                    HStack {
                        Text("QTY:")
                            .font(.customfont(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        if let qty=pObj.qty{
                            Text("\( qty )")
                                .font(.customfont(.bold, fontSize: 16))
                                .foregroundColor(.primaryText)
                        }
                        Text("×")
                            .font(.customfont(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        Text("$ \( pObj.itemPrice ?? 0.0, specifier: "%.2f" )")
                            .font(.customfont(.bold, fontSize: 16))
                            .foregroundColor(.primaryText)
                        
                        
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                }
                
                Text("$\((pObj.offerPrice ?? pObj.price) ?? 0.0, specifier: "%.2f" )")
                    .font(.customfont(.semibold, fontSize: 18))
                    .foregroundColor(.primaryText)
                
                
            }
            
            if showReviewBotton {
                CustomBTN(title: "Write a review" ) {
                    didTap?()
                }
            }
           
            
        }
            .padding(15)
            .background(Color.white)
            .cornerRadius(5)
            .shadow(color: Color.black.opacity(0.15), radius: 2)
            .padding(.horizontal, 20)
            .padding(.vertical, 4)
        
    }
}
