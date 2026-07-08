//
//  FavouriteRow.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

struct FavouriteRow: View {
    @State var fObj: ProductModel = ProductModel()

    var body: some View {
        VStack{
            HStack(spacing: 15){
                CacheAsyncImage(
                    url: URL(string: fObj.image ?? "") ?? URL(fileURLWithPath: "")
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
//                WebImage(url: URL(string: fObj.image ))
//                    .resizable()
//                    .indicator(.activity) // Activity Indicator
//                    .transition(.fade(duration: 0.5))
//                    .scaledToFit()
//                    .frame(width: 60, height: 60)
                
                VStack(spacing: 4){
                    
                    Text(fObj.name ?? "")
                        .font(.customfont(.bold, fontSize: 16))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Text("\(String(describing: fObj.unitValue))\(String(describing: fObj.unitName)), price")
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                }
                
                Text("$\((fObj.offerPrice ?? fObj.price) ?? 0.0, specifier: "%.2f" )")
                    .font(.customfont(.semibold, fontSize: 18))
                    .foregroundColor(.primaryText)
                    
                Image("next")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                
                
            }
            Divider()
        }

    }
}

#Preview {
    FavouriteRow()
}
