//
//  CustomTextField.swift
//  Food App
//
//  Created by hosam on 06/07/2026.
//

import SwiftUI

struct CustomTextField: View {
    var title:String = "Email"
    var hint:String = "Enter your Email"
    @Binding var text:String
    var type:UIKeyboardType = .emailAddress
    @State var isShowPassword: Bool=false
    @Binding var isPassField:Bool
    
    
    var body: some View {
        VStack(alignment: .leading,spacing: 12){
            Text(title)
                .font(.customfont(.regular, fontSize: 16))
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            if !isPassField{
                TextField(hint, text: $text)
                    .keyboardType(type)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }else{
                if isShowPassword{
                    TextField(hint, text: $text)
                        .keyboardType(type)
                        .modifier( ShowButton(isShow: $isShowPassword))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }else{
                    SecureField(hint, text: $text)
                        .keyboardType(type)
                        .modifier( ShowButton(isShow: $isShowPassword))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
            }
            
            Divider()
        }
    }
}

