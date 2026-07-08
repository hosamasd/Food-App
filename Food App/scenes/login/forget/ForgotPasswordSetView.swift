//
//  ForgotPasswordSetView.swift
//  Food App
//
//  Created by hosam on 06/07/2026.
//

import SwiftUI

struct ForgotPasswordSetView: View {
    @ObservedObject var vm:LoginSceneViewModel

    var body: some View {
        VStack{
            Text("Set New Password")
                .font(.customfont(.semibold, fontSize: 26))
                .foregroundColor(.primaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.vertical)
            
            Text("Enter your new password")
                .font(.customfont(.semibold, fontSize: 16))
                .foregroundColor(.secondaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, getFrameSize().width * 0.1)
            
            CustomTextField(title:"Password",hint:"Enter your password",text:$vm.new_password,isPassField: .constant(true) )
               
              
            CustomBTN(title: "Submit") {
                vm.forgetVerifySetPass()
            }
        }
    }
}

#Preview {
    ForgotPasswordSetView(vm: LoginSceneViewModel())
}
