//
//  PaymentMethodsView.swift
//  Food App
//
//  Created by hosam on 06/07/2026.
//

import SwiftUI

struct PaymentMethodsView: View {
    @Environment(\.presentationMode) var mode : Binding<PresentationMode>

    @StateObject var vm=PaymentMethodsViewModel()
    @State var isPicker: Bool = false
    var didSelect:( (_ obj: PaymentModel) -> () )?
    
    var body: some View {
        ZStack{
            ZStack{
                
                if vm.isLoading==false && vm.listArr.count <= 0{
                    Spacer()
                    EmptyViews(text: "no data founded")
                    Spacer()
                }else{
                    ScrollView{
                        LazyVStack(spacing: 15) {
//                            ForEach( vm.listArr , id: \.id, content: {
//                                pObj in
                                ForEach (vm.listArr.indices, id: \.self) {
                                    pObj in
                                HStack(spacing: 15) {
                                    
                                    Image("paymenth_methods")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 35, height: 35)
                                    
                                    VStack(spacing: 4){
                                        Text(vm.listArr[pObj].name ?? "")
                                            .font(.customfont(.bold, fontSize: 18))
                                            .foregroundColor(.primaryText)
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        
                                        Text("**** **** **** \(vm.listArr[pObj].cardNumber ?? "") ")
                                            .font(.customfont(.medium, fontSize: 15))
                                            .foregroundColor(.primaryApp)
                                            .multilineTextAlignment( .leading)
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        
                                    }
                                    
                                    Button {
                                        vm.removePayment(pObj: vm.listArr[pObj])
                                    } label: {
                                        Image("close")
                                            .resizable()
                                        
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                    }
                                }
                                .padding(15)
                                
                                .background(Color.white)
                                .cornerRadius(5)
                                .shadow(color: Color.black.opacity(0.15), radius: 2)
                                .onTapGesture {
                                    if(isPicker) {
                                        mode.wrappedValue.dismiss()
                                        didSelect?(vm.listArr[pObj])
                                    }
                                }
                                
                                
                                
                            }
                        }
                        .padding(20)
                        .padding(.top, .topInsets + 46)
                        .padding(.bottom, .bottomInsets + 60)
                        
                    }
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
                        
                        Text("Payment Methods")
                            .font(.customfont(.bold, fontSize: 20))
                            .frame(height: 46)
                        Spacer()
                        
                        NavigationLink {
                            AddPaymentMethodView(vm:vm )
                        } label: {
                            Image("add_temp")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                        
                        .foregroundColor(.primaryText)

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

