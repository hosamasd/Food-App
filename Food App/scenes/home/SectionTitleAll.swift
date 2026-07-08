//
//  SectionTitleAll.swift
//  Food App
//
//  Created by hosam on 08/07/2026.
//

import SwiftUI

struct SectionTitleAll: View {
    @State var title: String = " Title"
    @State var titleAll: String = "View All"
    var didTap : (()->())?
    @Namespace private var animation
    
    var body: some View {
        
        HStack{
            Text(title)
                .font(.customfont(.semibold, fontSize: 24))
                .foregroundColor(.primaryText)
                .matchedGeometryEffect(     id: title,
                                            in: animation )
            Spacer()
            
            Text(titleAll)
                .font(.customfont(.semibold, fontSize: 16))
                .foregroundColor(.primaryApp)
            
        }
        .frame(height: 40)
    }
}
