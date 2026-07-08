//
//  DelieryAddressView.swift
//  Food App
//
//  Created by hosam on 06/07/2026.
//

import SwiftUI

struct DelieryAddressView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    @StateObject var vm=DelieryAddressViewModel()
    @State var isPicker: Bool = false
    var didSelect:( (_ obj: AddressModel) -> () )?
    
    var body: some View {
        
        ZStack{
            ZStack{
                
                if(vm.listArr.count == 0 && vm.isLoading==false) {
                    EmptyViews(text: "no data founded")
                }else{
                    
                   
                    ScrollView{
                        LazyVStack(spacing: 15) {
                            ForEach (vm.listArr.indices, id: \.self) {
                                aObj in
//                                
                                HStack(spacing: 15) {
                                    VStack{
                                        HStack {
                                            Text(vm.listArr[aObj].name ?? "")
                                                .font(.customfont(.bold, fontSize: 14))
                                                .foregroundColor(.primaryText)
                                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                            
                                            
                                            Text(vm.listArr[aObj].typeName ?? "")
                                                .font(.customfont(.bold, fontSize: 12))
                                                .foregroundColor(.primaryText)
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 2)
                                                .background(Color.secondaryText.opacity(0.3))
                                                .cornerRadius(5)
                                        }
//                                        
                                        if let address=vm.listArr[aObj].address,let state = vm.listArr[aObj].state,let postalCode = vm.listArr[aObj].postalCode{
                                            Text(address+state+postalCode)
                                            
                                                .font(.customfont(.medium, fontSize: 14))
                                                .foregroundColor(.primaryText)
                                                .multilineTextAlignment( .leading)
                                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        }
//                                        
                                        Text(vm.listArr[aObj].phone ?? "")
                                            .font(.customfont(.bold, fontSize: 12))
                                            .foregroundColor(.secondaryText)
                                            .padding(.vertical, 8)
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                                        
                                    }
//                                    
                                    VStack{
                                        
                                        Spacer()
                                        
                                                                            NavigationLink {
                                                                                AddDeliveryAddressView(vm:vm,isEdit: true, editObj: vm.listArr[aObj]  )
                                                                            } label: {
                                                                                Image(systemName: "pencil")
                                                                                    .resizable()
                                                                                    .frame(width: 20, height: 20)
                                                                                    .foregroundColor(.primaryApp)
                                                                            }
                                                                            .padding(.bottom, 8)
                                        
                                        
                                        
                                        Button {
                                            vm.serviceCallRemove(cObj: vm.listArr[aObj])
                                            //                                        vm.serviceCallRemove(cObj: aObj)
                                        } label: {
                                            Image("close")
                                                .resizable()
                                            
                                                .scaledToFit()
                                                .frame(width: 20, height: 20)
                                        }
                                        
                                        Spacer()
                                        
                                    }
                                }
                                .padding(15)
                                .background(Color.white)
                                .cornerRadius(5)
                                .shadow(color: Color.black.opacity(0.15), radius: 2)
                                .onTapGesture {
                                    if(isPicker) {
                                        mode.wrappedValue.dismiss()
                                        didSelect?(vm.listArr[aObj])
                                    }
                                    }
                                
//                                
//                                
                            }
                        }
                        .padding(20)
                        .padding(.top, .topInsets + 46)
                        .padding(.bottom, .bottomInsets + 60)
//                        
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
                        
                        Text("Delivery Address")
                            .font(.customfont(.bold, fontSize: 20))
                            .frame(height: 46)
                        Spacer()
                        
                        
                        NavigationLink {
                            AddDeliveryAddressView(vm:vm)
                        } label: {
                            Image("add_temp")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                        
                        .foregroundColor(.primaryText)
                        .padding(.bottom, 8)
                        
                        

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
