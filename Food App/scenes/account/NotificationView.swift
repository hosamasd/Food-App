//
//  NotificationView.swift
//  Food App
//
//  Created by hosam on 06/07/2026.
//

import SwiftUI

struct NotificationView: View {
    @ObservedObject var vm:AccountViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {
        ZStack{
            ZStack{
                if(vm.listArrNotification.count == 0) {
                    EmptyView(text: "no data founded")
                }
                
                ScrollView{
                    LazyVStack(spacing: 15) {
                        ForEach( vm.listArrNotification , id: \.id, content: {
                            nObj in
                            
                            
                            VStack{
                                HStack {
                                    Text(nObj.title ?? "")
                                        .font(.customfont(.bold, fontSize: 14))
                                        .foregroundColor(.primaryText)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    
                                    if let date=nObj.createdDate{
                                        Text(date.displayDate(format: "yyyy-MM-dd hh:mm a"))
                                            .font(.customfont(.regular, fontSize: 12))
                                            .foregroundColor(.secondaryText)
                                    }
                                }
//                                
//                           
//                                    
                                    Text(nObj.message ?? "")
                                        .font(.customfont(.medium, fontSize: 14))
                                        .foregroundColor(.primaryText)
                                        .multilineTextAlignment( .leading)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                                    
                                }
                             
                            .padding(15)
                            .background( nObj.isRead == 1 ? Color.placeholder : Color.white)
                            .cornerRadius(5)
                            .shadow(color: Color.black.opacity(0.15), radius: 2)
                           


                        })
                    }
                    .padding(20)
                    .padding(.top, .topInsets + 46)
                    .padding(.bottom, .bottomInsets + 60)

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
                        
                            Text("Notification")
                                .font(.customfont(.bold, fontSize: 20))
                                .frame(height: 46)
                       
                        Spacer()
                        
                    if vm.listArrNotification.count > 0{
                        Button {
                            vm.readAllNotifications()
                        } label: {
                            Text("Read All")
                                .font(.customfont(.bold, fontSize: 16))
                                .foregroundColor(.primaryApp)
                        }
                    }
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
        .onAppear {
            vm.getAllNotification()
        }
    }
}

#Preview {
    NotificationView(vm: AccountViewModel())
}
