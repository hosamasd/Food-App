//
//  SeeAllScene.swift
//  Food App
//
//  Created by hosam on 08/07/2026.
//

import SwiftUI

struct SeeAllScene: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var vm:HomeViewModel
//    var listType:[TypeModel] = []

    var title = ""
    var isBest=0
    var isCategory = false
    @Namespace private var animation

    func getArr() -> [ProductModel] {
        isBest==0 ? vm.offerArr : isBest==1 ? vm.bestArr : vm.listArr
    }
    
    var body: some View {
        ZStack{
            ZStack{
                if !isCategory {
                    ScrollView( showsIndicators: false ) {
                        LazyVStack(spacing: 15) {
                            ForEach (getArr().indices, id: \.self) {
                                pObj in
                                
                                ProductCell(vm:ExploreViewModel(),pObj: getArr()[pObj],isFull:true, didAddCart: {
                                    
                                    vm.addToCart(prodId: getArr()[pObj].prodId ?? 1 , qty: 1) { isDone, msg in
                                        
                                        self.vm.alertMsg = msg
                                        self.vm.alertError = true
                                    }
                                })
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 4)
                    }
                    .padding(.top,80)
                    .padding(.horizontal)
                }else{
                    ScrollView( showsIndicators: false ) {
                        LazyVStack(spacing: 15) {
                            
                            ForEach (vm.typeArr.indices, id: \.self) {
                                tObj in
                                
                                CategoryCell(tObj: vm.typeArr[tObj],isFull:true) {
                                    
                                }
                            }
                            
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 4)
                    }
                    .padding(.top,80)
                    .padding(.horizontal)
                }
                
                VStack{
                        
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
                        
                            Text(title)
                                .font(.customfont(.bold, fontSize: 20))
                                .frame(height: 46)
                                .matchedGeometryEffect(id: title, in: animation)

                        Spacer()
                        
                   
                    }
                    .padding(.top, .topInsets)
                    .padding(.horizontal, 20)
                    .background(Color.white)
                    .shadow(color: Color.black.opacity(0.2),  radius: 2 )
                    
                    Spacer()
                    
                }
            }
           
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
//        .overlay(overlayView: Toasts.init(dataModel: Toasts.ToastDataModel.init(title: vm.alertMsg, image: "checkmark"), show: $vm.alert)
//                 , show: $vm.alert)
//        .alert(
//            isPresented: $vm.alertError,
//            content: { Alert(title: Text(LocalizedStringKey(vm.alertMsg)))
//            })
    }
}
