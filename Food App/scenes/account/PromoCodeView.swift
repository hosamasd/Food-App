//
//  PromoCodeView.swift
//  Food App
//
//  Created by hosam on 06/07/2026.
//

import SwiftUI

struct PromoCodeView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var isPicker: Bool = false
    var didSelect:( (_ obj: PromoCodeModel) -> () )?
    @StateObject var vm=PromoCodeViewModel()
    
    var body: some View {
        ZStack{
            ZStack{
                if(vm.listArr.count == 0) {
                    EmptyView(text: "no data founded")
                }
                ScrollView{
                    LazyVStack(spacing: 15) {
                        ForEach( vm.listArr , id: \.id, content: {
                            pObj in
                            
                            VStack{
                                HStack {
                                    Text(pObj.title ?? "")
                                        .font(.customfont(.bold, fontSize: 14))
                                        .foregroundColor(.primaryText)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                    
                                    Text(pObj.code ?? "")
                                        .font(.customfont(.bold, fontSize: 15))
                                        .foregroundColor(.primaryApp)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 2)
                                        .background(Color.secondaryText.opacity(0.3))
                                        .cornerRadius(5)
                                }
                                
                                Text(pObj.description ?? "")
                                    .font(.customfont(.medium, fontSize: 14))
                                    .foregroundColor(.secondaryText)
                                    .multilineTextAlignment( .leading)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                                HStack{
                                    Text("Expiry Date:")
                                        .font(.customfont(.bold, fontSize: 14))
                                        .foregroundColor(.primaryText)
                                        .padding(.vertical, 8)
                                    
                                    
                                    Text( pObj.endDate?.displayDate(format: "yyyy-MM-dd hh:mm a") ?? "")
                                        .font(.customfont(.bold, fontSize: 12))
                                        .foregroundColor(.secondaryText)
                                        .padding(.vertical, 8)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                }
                            }
                            .padding(15)
                            .background(Color.white)
                            .cornerRadius(5)
                            .shadow(color: Color.black.opacity(0.15), radius: 2)
                            .onTapGesture {
                                if(isPicker) {
                                    mode.wrappedValue.dismiss()
                                    didSelect?(pObj)
                                }
                            }
                            
                        })
                    }
                    .padding(20)
                    .padding(.top, .topInsets + 46)
                    .padding(.bottom, .bottomInsets + 60)
                    
                }
             TopHeaderView(title: "Promo Code")
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

#Preview {
    PromoCodeView()
}
