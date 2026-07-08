//
//  OTPView.swift
//  Food App
//
//  Created by hosam on 06/07/2026.
//

import SwiftUI

struct OTPView: View {
    @ObservedObject var vm:LoginSceneViewModel

    var body: some View {
        VStack{
            Text("Enter your 4-digit code")
                .font(.customfont(.semibold, fontSize: 26))
                .foregroundColor(.primaryText)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.vertical)
            
            OtpFormFieldView(total:$vm.resetCode,type:.default)

//            CustomTextField(title:"Code",hint:"- - - -",text:$vm.resetCode,type: .numberPad,isPassField: .constant(false) )
            
            HStack{
                Button {
                    vm.forget()
                } label: {
                    Text("Resend Code")
                        .font(.customfont(.bold, fontSize: 18))
                        .foregroundColor(.primaryApp)
                        
                }
                Spacer()
                Button {
                    vm.forgetVerify()
                } label: {
                    Image("next")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .padding(15)
                }
                .foregroundColor(.white)
                .background(Color.primaryApp)
                .cornerRadius(30)
                
            }
        }
    }
}

#Preview {
    OTPView(vm: LoginSceneViewModel())
}
