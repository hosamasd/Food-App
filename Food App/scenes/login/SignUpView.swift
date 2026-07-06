//
//  SignUpScene.swift
//  Food App
//
//  Created by hosam on 06/07/2026.
//

import SwiftUI

struct SignUpView: View {
    @ObservedObject var vm:LoginSceneViewModel
    
    var body: some View {
//        ScrollView{
            VStack{
               
                Text("Sign Up")
                    .font(.customfont(.semibold, fontSize: 26))
                    .foregroundColor(.primaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical)
                
                Text("Enter your credentials to continue")
                    .font(.customfont(.semibold, fontSize: 16))
                    .foregroundColor(.secondaryText)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, getFrameSize().width * 0.1)
                
                VStack(spacing:12){
                    CustomTextField(title:"Username",hint: "Enter your username",text:$vm.username,type: .default,isPassField: .constant(false) )
                    
                    CustomTextField(text:$vm.emailSignup,isPassField: .constant(false) )
                    
                    CustomTextField(title:"Password",hint:"Enter your password",text:$vm.passSignup,isPassField: .constant(true) )
                    
                }
                
                VStack {
                    Text("By continuing you agree to our")
                        .font(.customfont(.medium, fontSize: 14))
                        .foregroundColor(.secondaryText)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    HStack{
                        
                        Text("Terms of Service")
                            .font(.customfont(.medium, fontSize: 14))
                            .foregroundColor(.primaryApp)
                            
                        
                        Text(" and ")
                            .font(.customfont(.medium, fontSize: 14))
                            .foregroundColor(.secondaryText)
                            
                        
                        Text("Privacy Policy.")
                            .font(.customfont(.medium, fontSize: 14))
                            .foregroundColor(.primaryApp)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                    }
                    .padding(.bottom, getFrameSize().width * 0.02)
                    
                    CustomBTN(title: "SignUp") {
                        vm.signUp()
                    }
                    
                    HStack{
                        Text("Alredy have an account?")
                            .font(.customfont(.semibold, fontSize: 14))
                            .foregroundColor(.primaryText)
                        
                        Text("Sign In")
                            .font(.customfont(.semibold, fontSize: 14))
                            .foregroundColor(.primaryApp)
                            .onTapGesture {
                                withAnimation(.spring){
                                    vm.isLogin=0
                                }
                            }
                    }
                }
                .padding(.top)
//            }
        }
    }
}

#Preview {
    SignUpView(vm: LoginSceneViewModel())
}
