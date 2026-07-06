//
//  WelcomeScene.swift
//  Food App
//
//  Created by hosam on 06/07/2026.
//

import SwiftUI

struct WelcomeScene: View {
    var body: some View {
        Image("welcom_bg")
            .resizable()
            .scaledToFill()
            .frame(width: getFrameSize().width, height: getFrameSize().height)
            .overlay(alignment: .bottom) {
                VStack{
                    Image("app_logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                    
                    Text( "Welcome\nto our store")
                        .font(.customfont(.semibold, fontSize: 48))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Text( "Ger your groceries in as fast as one hour")
                        .font(.customfont(.medium, fontSize: 16))
                        .foregroundColor(.white.opacity(0.7))
                        .multilineTextAlignment(.center)
                        .padding(.bottom,60)
                    
                    NavigationLink {
                        LoginScene()
                    } label: {
                        Text("Get Started")
                            .font(.customfont(.semibold, fontSize: 18))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                    }
                    .frame( width: getFrameSize().width-48,height: 60)
                    .background( Color.primaryApp)
                    .cornerRadius(20)
                    .padding(.bottom,getFrameSize().height/7.5)
                }
            }
            .navigationTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .ignoresSafeArea()
    }
}

#Preview {
    WelcomeScene()
}
