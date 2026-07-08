//
//  AddPaymentMethodView.swift
//  Food App
//
//  Created by hosam on 08/07/2026.
//

import SwiftUI

struct AddPaymentMethodView: View {
    @Environment(\.presentationMode) var mode : Binding<PresentationMode>
    @ObservedObject var vm:PaymentMethodsViewModel
    var body: some View {
        ZStack{
        
            ZStack {
                
                ScrollView{
                    VStack(spacing: 15){
                        
                                            
                        
                        CustomTextField(title: "Name",hint:"Enter name",text:$vm.txtName,type: .default,isPassField: .constant(false) )

                        CustomTextField(title: "Card Number",hint:"Enter card number",text:$vm.txtCardNumber,type: .numberPad,isPassField: .constant(false) )

                        
                       
                        
                        HStack{
                            CustomTextField(title: "MM",hint:"Enter Month",text:$vm.txtCardMonth,type: .numberPad,isPassField: .constant(false) )

                            CustomTextField(title: "YYYY",hint:"Enter Year",text:$vm.txtCardYear,type: .numberPad,isPassField: .constant(false) )
                        }
                       
                        
                        CustomBTN(title:  "Add Payment Method") {
                            
                                vm.serviceCallAdd {
                                    self.mode.wrappedValue.dismiss()
                                }
                            
                        }
                        
                    }
                    .padding(20)
                    .padding(.top, .topInsets + 46)

                }
                
                VStack {
                        
                    HStack{
                        
                        Button {
                            mode.wrappedValue.dismiss()
                        } label: {
                            Image("back")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }

                        
                       
                        Spacer()
                        
                        Text("Add Payment Method")
                            .font(.customfont(.bold, fontSize: 20))
                            .frame(height: 46)
                        Spacer()
                        
                        

                    }
                    .padding(.top, .topInsets)
                    .padding(.horizontal, 20)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.2),  radius: 2 )
                    
                    Spacer()
                    
                }
            }
            if vm.isLoading{
                ArcView()
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
