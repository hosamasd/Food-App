//
//  TopHeaderView.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

struct TopHeaderView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var title:String = "My Ordres"
    
    var body: some View {
      VStack  {
            
            HStack{
                
                Button {
                    mode.wrappedValue.dismiss()
                } label: {
                    Image("back")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                
                
                
                Spacer()
                
                Text(title)
                    .font(.customfont(.bold, fontSize: 20))
                    .frame(height: 46)
                Spacer()
                
                
                
            }
            .padding(.top, .topInsets)
            .padding(.horizontal, 20)
            .background(Color.white)
            .shadow(color: Color.black.opacity(0.2),  radius: 2 )
            
            Spacer()
            
        }
    }
}

#Preview {
    TopHeaderView()
}
