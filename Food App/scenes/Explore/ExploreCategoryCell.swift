//
//  ExploreCategoryCell.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

struct ExploreCategoryCell: View {
    @State var cObj: ExploreCategoryModel = ExploreCategoryModel()

    var body: some View {
        VStack{
            
//            WebImage(url: URL(string: cObj.image ))
//                .resizable()
//                .indicator(.activity) // Activity Indicator
//                .transition(.fade(duration: 0.5))
//                .scaledToFit()
//                .frame(width: 120, height: 90)
            
        
            Spacer()
            Text(cObj.name ?? "")
                .font(.customfont(.bold, fontSize: 16))
                .foregroundColor(.primaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
            
            Spacer()
            
        }
        .padding(15)
        .background( Color.primaryApp.opacity(0.3) )
        .cornerRadius(16)
        .overlay (
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.primaryApp, lineWidth: 1)
        )
    }
}
