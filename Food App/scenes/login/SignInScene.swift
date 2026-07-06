////
////  SignInScene.swift
////  Food App
////
////  Created by hosam on 06/07/2026.
////
//
//import SwiftUI
//
//struct SignInScene: View {
//    var body: some View {
//        ZStack{
//            Image("bottom_bg")
//                .resizable()
//                .scaledToFill()
//                .frame(width: getFrameSize().width, height: getFrameSize().height)
//            
//            VStack{
//                Image("sign_in_top")
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: getFrameSize().width, height: getFrameSize().height)
//                
//                Spacer()
//            }
//            
//            ScrollView{
//                VStack(alignment: .leading){
//                    Text( "Get your groceries\nwith nectar")
//                        .font(.customfont(.semibold, fontSize: 26))
//                        .foregroundStyle(Color.primaryText)
//                        .multilineTextAlignment(.leading)
//                        .padding(.bottom , 25)
//                    
//                    signIn
//                    
//                    signUp
//                    
//                    Divider()
//                        .padding(.bottom, 25)
//                    
//                    Text( "Or connect with social media")
//                        .font(.customfont(.semibold, fontSize: 14))
//                        .foregroundColor(.textTitle)
//                        .multilineTextAlignment(.center)
//                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
//                        .padding(.bottom , 25)
//                    
//                    
//                    
//                    loginWithSocial
//                }
//                .padding(.horizontal, 20)
//                .frame(width: getFrameSize().width, alignment: .leading)
//                .padding(.top, .topInsets +  .screenWidth * 0.6  )
//                .padding(.bottom,40)
//            }
//        }
//        .navigationTitle("")
//        .navigationBarBackButtonHidden(true)
//        .navigationBarHidden(true)
//        .ignoresSafeArea()
//    }
//}
//
//#Preview {
//    SignInScene()
//}
//extension SignInScene{
//    private var signIn :some View {
//        NavigationLink {
//            LoginScene()
//        } label: {
//            Text("Continue with Email Sign In")
//                .font(.customfont(.semibold, fontSize: 18))
//                .foregroundColor(.white)
//                .multilineTextAlignment(.center)
//        }
//        .frame( minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60 )
//        .background( Color(hex: "5383EC"))
//        .cornerRadius(20)
//        .padding(.bottom, 8 )
//    }
//    
//    private var signUp :some View {
//        NavigationLink {
//            LoginScene()
//        } label: {
//            Text("Continue with Email Sign Up")
//                .font(.customfont(.semibold, fontSize: 18))
//                .foregroundColor(.white)
//                .multilineTextAlignment(.center)
//        }
//        .frame( minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60 )
//        .background( Color.primaryApp)
//        .cornerRadius(20)
//        .padding(.bottom, 8 )
//    }
//    
//    private var loginWithSocial :some View {
//        VStack{
//            Button {
//                
//            } label: {
//                
//                Image("google_logo")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 20, height: 20)
//                
//                Text("Continue with Google")
//                    .font(.customfont(.semibold, fontSize: 18))
//                    .foregroundColor(.white)
//                    .multilineTextAlignment(.center)
//            }
//            .frame( minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60 )
//            .background( Color(hex: "5383EC"))
//            .cornerRadius(20)
//            .padding(.bottom, 8 )
//            
//            Button {
//                
//            } label: {
//                
//                Image("fb_logo")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 20, height: 20)
//                
//                Text("Continue with Facebook")
//                    .font(.customfont(.semibold, fontSize: 18))
//                    .foregroundColor(.white)
//                    .multilineTextAlignment(.center)
//            }
//            .frame( minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60 )
//            .background( Color(hex: "4A66AC"))
//            .cornerRadius(20)
//        }
//    }
//}
