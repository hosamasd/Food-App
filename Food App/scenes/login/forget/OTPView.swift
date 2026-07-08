//
//  OTPView.swift
//  Food App
//
//  Created by hosam on 06/07/2026.
//

import SwiftUI

struct OTPView: View {
    @ObservedObject var vm:LoginSceneViewModel
    @State private var isActive: Bool = true

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
                    Text(vm.timerValue <= 0 ? "Resend Code" : vm.formattedTimer)
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
        .onAppear {
            startTimer()
        }
    }
    
    func startTimer()  {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if !isActive {
                timer.invalidate()
                return
            }
            if vm.timerValue <= 0 {
                timer.invalidate()
                return
            }
            
            if self.vm.timerValue > 0 {
                self.vm.timerValue -= 1
            }
        }

    }
}

#Preview {
    OTPView(vm: LoginSceneViewModel())
}
