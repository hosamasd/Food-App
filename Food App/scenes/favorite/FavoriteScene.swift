//
//  FavoriteScene.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

struct FavoriteScene: View {
    @StateObject var vm=FavoriteViewModel()
    var body: some View {
        ZStack{
            ZStack{
                
                if(vm.listArr.count == 0) {
                    EmptyView(text: "no data founded")
                }
                ScrollView{
                    LazyVStack {
                        ForEach( vm.listArr , id: \.id, content: {
                            fObj in
                            
                            FavouriteRow(fObj: fObj)
                            
                        })
                    }
                    .padding(20)
                    .padding(.top, .topInsets + 46)
                    .padding(.bottom, .bottomInsets + 60)
                    
                }
                
                
                VStack {
                    
                    HStack{
                        
                        Spacer()
                        
                        Text("Favorites")
                            .font(.customfont(.bold, fontSize: 20))
                            .frame(height: 46)
                        Spacer()
                        
                    }
                    .padding(.top, .topInsets)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.2),  radius: 2 )
                    
                    Spacer()
                    
                    
                    CustomBTN(title: "Add All To Cart")
                        .padding(.horizontal, 20)
                        .padding(.bottom, .bottomInsets + 80)
                    
                }
                
                
                
            }
            .onAppear{
                vm.serviceCallList()
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
            content: { Alert(title: Text(LocalizedStringKey(vm.alertMsg)))
            })
    }
}


