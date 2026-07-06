//
//  MyDetailsView.swift
//  Food App
//
//  Created by hosam on 06/07/2026.
//

import SwiftUI

struct MyDetailsView: View {
    @ObservedObject var vm:AccountViewModel
    @State var username=""
    @State var name=""

    var body: some View {
            
//            ScrollView{
        VStack{
            VStack(spacing: 15){
                
                backBTN
                
                CustomTextField(title: "Username",hint:"Enter you Username",text:$name ,isPassField: .constant(false) )
                CustomTextField(title: "Name",hint:"Enter you name",text:$username ,isPassField: .constant(false) )
                
                CustomBTN(title:"Update") {
                    vm.update( name:name,username:username,mobile:"01001384592",mobile_code: "+2")
                }
                .padding(.bottom, 45)
                
                //                    NavigationLink {
                ////                        ChangePasswordView()
                //                    } label: {
                //                        Text("Change Password")
                //                            .font(.customfont(.bold, fontSize: 18))
                //                            .foregroundColor(.primaryApp)
                //                    }
                
                
            }
            .padding(20)
         
            Spacer()
        }
//            }
            
          
        .onAppear {
            setData()
        }
    }
    
    func setData()  {
        username=vm.currentUser.username ?? ""
        name=vm.currentUser.name ?? ""

    }
}
extension MyDetailsView{
    private var backBTN :some View {
        HStack{
            Button {
                withAnimation{
                    vm.isHome=true
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
