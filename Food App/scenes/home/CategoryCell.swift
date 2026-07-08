//
//  CategoryCell.swift
//  Food App
//
//  Created by hosam on 08/07/2026.
//

import SwiftUI

struct CategoryCell: View {
    @State var tObj: TypeModel = TypeModel()
    @State var color: Color = Color.yellow
    var isFull=false
    var didAddCart: ( ()->() )?
    
    var body: some View {
        HStack{
            
            CacheAsyncImage(
                url: URL(string: tObj.image ?? "") ?? URL(fileURLWithPath: "")
            ) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
//                            .indicator(.activity) // Activity Indicator
//                            .transition(.fade(duration: 0.5))
                            .scaledToFit()
                            .frame(width: 70, height: 70)
                    @unknown default:
                        fatalError()
                    }
                }
//            WebImage(url: URL(string: tObj.image ))
//                .resizable()
//                .indicator(.activity) // Activity Indicator
//                .transition(.fade(duration: 0.5))
//                .scaledToFit()
//                .frame(width: 70, height: 70)
            
        
            
            Text(tObj.type_name ?? "")
                .font(.customfont(.bold, fontSize: 16))
                .foregroundColor(Color(hex: tObj.color ?? "53B175") )
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
        }
        .padding(15)
        .frame(width:isFull ? getFrameSize().width-24 : 250, height: 100)
        .background( Color.primaryApp.opacity(0.3) )
        .cornerRadius(16)
    }
}
