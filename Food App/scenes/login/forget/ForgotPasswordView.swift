//
//  ForgotPasswordView.swift
//  Food App
//
//  Created by hosam on 06/07/2026.
//

import SwiftUI

struct ForgotPasswordView: View {
    @ObservedObject var vm:LoginSceneViewModel

    var body: some View {
        VStack{
          
            Text("Forgot Password")
                .font(.customfont(.semibold, fontSize: 26))
                .foregroundColor(.primaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.vertical)
            
            Text("Enter your emails")
                .font(.customfont(.semibold, fontSize: 16))
                .foregroundColor(.secondaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, getFrameSize().width * 0.1)
            
                CustomTextField(text:$vm.emailForget,isPassField: .constant(false) )
                .padding(.bottom,8)
              
            CustomBTN(title: "Forget") {
                vm.forget()
            }
            
            
        }
    }
}

#Preview {
    ForgotPasswordView(vm: LoginSceneViewModel())
}
