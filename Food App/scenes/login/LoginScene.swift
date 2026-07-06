//
//  LoginScene.swift
//  Food App
//
//  Created by hosam on 06/07/2026.
//

import SwiftUI

struct LoginScene: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @StateObject var vm=LoginSceneViewModel()
    
    var body: some View {
        
        Image("bottom_bg")
            .resizable()
            .frame(width: getFrameSize().width,height: getFrameSize().height)
            .ignoresSafeArea()
            .overlay {
                ZStack {
                    VStack(spacing:16){
                        
                        backBTN
                        
                        Image("color_logo")
                            .resizable()
                            .frame(width: 40,height: 40)
                        
                        if vm.isLogin==0{
                            
                            
                            VStack(spacing:16){
                                firstSection
                                
                                CustomTextField(text:$vm.emailLogin,isPassField: .constant(false) )
                                
                                CustomTextField(title:"Password",hint:"Enter your password",text:$vm.passLogin,isPassField: .constant(true) )
                                
                                HStack{
                                    Button {
                                        withAnimation(.spring){
                                            vm.isLogin=2
                                        }
                                    } label: {
                                        Text("Forget Password?")
                                    }
                                    Spacer()
                                }
                                
                                CustomBTN {
                                    vm.login()
                                }
                                
                                HStack{
                                    Text("Don’t have an account?")
                                        .font(.customfont(.semibold, fontSize: 14))
                                        .foregroundColor(.primaryText)
                                    
                                    Text("Signup")
                                        .font(.customfont(.semibold, fontSize: 14))
                                        .foregroundColor(.primaryApp)
                                        .onTapGesture {
                                            withAnimation(.spring){
                                                vm.isLogin=1
                                            }
                                        }
                                }
                                
                                Spacer()
                            }
                            
                        }else if vm.isLogin==1{
                            SignUpView(vm:vm)
                            
                        }else if vm.isLogin==2{
                            ForgotPasswordView(vm:vm)
                        }else if vm.isLogin==3{
                            OTPView(vm:vm)
                        }else{
                            ForgotPasswordSetView(vm: vm)
                        }
                      
                        Spacer()
                    }
                    .padding()
                    if vm.isLoading{
                        ArcView()
                    }
                }
                
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea()
            .overlay(overlayView: Toasts.init(dataModel: Toasts.ToastDataModel.init(title: vm.alertMsg, image: "checkmark"), show: $vm.alert)
                     , show: $vm.alert)
            .alert(
                isPresented: $vm.alertError,
                content: { Alert(title: Text(LocalizedStringKey(vm.alertMsg))) })
    }
}

#Preview {
    LoginScene()
}
extension LoginScene{
    private var firstSection :some View {
        HStack{
            VStack(alignment: .leading,spacing: 8){
                Text("Loginig")
                    .font(.customfont(.semibold, fontSize: 26))
                    .foregroundStyle(Color.primaryText )
                
                Text("Enter your emails and password")
                    .font(.customfont(.regular, fontSize: 16))
                    .foregroundStyle(Color.darkGray )
            }
            Spacer()
        }
        .padding(.vertical)
    }
    
    private var backBTN :some View {
        HStack{
            Button {
                withAnimation{
                    if vm.isLogin==4{
                        vm.isLogin=3
                    }else if vm.isLogin==3{
                        vm.isLogin=2
                    }else if vm.isLogin==2{
                        vm.isLogin=0
                    }else if vm.isLogin==1{
                        vm.isLogin=0
                    }else{
                        mode.wrappedValue.dismiss()
                    }
                }
            } label: {
                Image("back")
                    .resizable()
                    .frame(width: 20,height: 20)
            }
            Spacer()
        }
    }
}
