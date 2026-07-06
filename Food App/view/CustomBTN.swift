//
//  CustomBTN.swift
//  Food App
//
//  Created by hosam on 06/07/2026.
//

import SwiftUI

struct CustomBTN: View {
    var title:String = "Log In"
    var bgColor:Color = Color.primaryApp
    var font:Font = .customfont(.medium, fontSize: 20)
    var action:(()->())?
    
    
    var body: some View {
        Button {
            action?()
        } label: {
            RoundedRectangle(cornerRadius: 20)
                .fill(bgColor)
                .frame(height:60)
                .overlay {
                    Text(title)
                        .font(font)
                        .foregroundStyle(Color.white)
                }
        }
    }
}

#Preview {
    CustomBTN(action: {})
}
