//
//  ExploreItemsView.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

struct ExploreItemsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var vm:ExploreViewModel
    var category:ExploreCategoryModel
    var columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        ZStack{
            ZStack{
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
                        
                        Text(category.cat_name ?? "Category")
                            .font(.customfont(.bold, fontSize: 20))
                            .frame(height: 46)
                        Spacer()
                        
//                        Button(action: {
//                            
//                        }, label: {
//                            Image("add_green")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 20, height: 20)
//                        })
//                        .frame(width: 40, height: 40)
                        
                    }
//                    .padding(.top, .topInsets)
//                    .padding(.horizontal, 20)
                    
                    if vm.listProductArr.count <= 0,vm.isLoading==false{
                        VStack{
                            Spacer()
                            EmptyViews(text: "no data founded")
                            Spacer()
                        }
                       
                    }else{
                        
                        ScrollView {
                            LazyVGrid(columns: columns,  spacing:15) {
                                
                                ForEach (vm.listProductArr.indices, id: \.self) {
                                    pObj in
                                    ProductCell( vm:vm,pObj: vm.listProductArr[pObj], width: .infinity ) {
                                        
                                        vm.addToCart(prodId: vm.listProductArr[pObj].prodId ?? 1, qty: 1) { isDone, msg in
                                            
                                            self.vm.alertMsg = msg
                                            self.vm.alertError = true
                                        }
                                    }
                                    
                                }
                            }
                            .padding(.vertical, 10)
                            .padding(.bottom, .bottomInsets + 60)
                        }
                    }
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                
            }
            
            if vm.isLoading{
                ArcView()
            }
        }
        .onAppear(perform: {
            vm.getProdcts(cObj: category)
        })
       
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
