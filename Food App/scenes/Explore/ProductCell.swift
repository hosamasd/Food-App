//
//  ProductCell.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

struct ProductCell: View {
    @ObservedObject var vm:ExploreViewModel
    @State var pObj: ProductModel = ProductModel()
    @State var width:Double = 180.0
    var didAddCart: ( ()->() )?
    
    
    var body: some View {
        NavigationLink {
            ProductDetailScene( vm: vm, pObj: pObj)
//            ProductDetailView(detailVM:  ProductDetailViewModel(prodObj: pObj) )
        } label: {
            VStack{
                
                CacheAsyncImage(
                    url: URL(string:  pObj.image ?? ""  ) ?? URL(fileURLWithPath: "")
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
                                .frame(width: 100, height: 80)
                    @unknown default:
                        fatalError()
                    }
                }
                
                Spacer()
                
                Text(pObj.name ?? "")
                    .font(.customfont(.bold, fontSize: 16))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Text("\(String(describing: pObj.unitValue))\(String(describing: pObj.unitName)), price")
                    .font(.customfont(.medium, fontSize: 14))
                    .foregroundColor(.secondaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                HStack{
                    Text("$\((pObj.offerPrice ?? pObj.price) ?? 0.0, specifier: "%.2f" )")
                        .font(.customfont(.semibold, fontSize: 18))
                        .foregroundColor(.primaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    Button {
                        
                        didAddCart?()
                    } label: {
                        Image("add")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                    }
                    .frame(width: 40, height: 40)
                    .background( Color.primaryApp)
                    .cornerRadius(15)
                    
                    
                }
                
            }
            .padding(15)
            .frame(width: width, height: 230)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(  Color.placeholder.opacity(0.5), lineWidth: 1)
            )
        }
        
    }
}

