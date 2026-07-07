//
//  MyOrdersView.swift
//  Food App
//
//  Created by hosam on 06/07/2026.
//

import SwiftUI

struct MyOrdersView: View {
    @StateObject var vm=MyOrdersViewModel()
    
    var body: some View {
        ZStack{
            ZStack{
                
                ScrollView{
                    LazyVStack(spacing: 15) {
                        ForEach( vm.listArr , id: \.id, content: {
                            myObj in
                            
                            NavigationLink {
                                MyOrdersDetailView(detailVM: MyOrderDetailViewModel(prodObj: myObj),vm:vm )
                            } label: {
                                MyOrderCellView(myObj:myObj)
                                
                            }
                            .padding(15)
                            .background(Color.white)
                            .cornerRadius(5)
                            .shadow(color: Color.black.opacity(0.15), radius: 2)
                        })
                    }
                    .padding(20)
                    .padding(.top, .topInsets + 46)
                    .padding(.bottom, .bottomInsets + 60)
                    
                }
                
                
                TopHeaderView()
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
    MyOrdersView()
}
