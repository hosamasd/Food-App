//
//  ProductDetailView.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

struct ProductDetailScene: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @ObservedObject var vm:ExploreViewModel
    var pObj:ProductModel
    
    var body: some View {
        ZStack{
            ZStack{
                
                ScrollView {
                    ZStack{
                          Rectangle()
                            .foregroundColor( Color(hex: "F2F2F2") )
                            .frame(width: .screenWidth, height: .screenWidth * 0.8)
                            .cornerRadius(20, corner: [.bottomLeft, .bottomRight])
                        
                        CacheAsyncImage(
                            url: URL(string: pObj.image ?? "") ?? URL(fileURLWithPath: "")
                        ) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
//                                        .indicator(.activity) // Activity Indicator
//                                        .transition(.fade(duration: 0.5))
                                        .scaledToFit()
                                        .frame(width: .screenWidth * 0.8, height: .screenWidth * 0.8)
                                @unknown default:
                                    fatalError()
                                }
                            }
//                        WebImage(url: URL(string: detailVM.pObj.image ))
//                            .resizable()
//                            .indicator(.activity) // Activity Indicator
//                            .transition(.fade(duration: 0.5))
//                            .scaledToFit()
//                            .frame(width: .screenWidth * 0.8, height: .screenWidth * 0.8)
                    }
                    .frame(width: .screenWidth, height: .screenWidth * 0.8)
                    
                    VStack{
                        HStack{
                            Text(pObj.name ?? "")
                                .font(.customfont(.bold, fontSize: 24))
                                .foregroundColor(.primaryText)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            Button {
                                vm.serviceCallAddRemoveFav(pObj: pObj)
                            } label: {
                                
                                Image( vm.isFav ? "favorite" : "fav"  )
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                            .foregroundColor(Color.secondaryText)

                        }
                        Text("\(pObj.unitValue)\(pObj.unitName), Price")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.secondaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        HStack{
                            
                            Button {
                                vm.addSubQTY(isAdd: false)
                            } label: {
                                
                                Image( "subtack"  )
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .padding(10)
                            }
                            
                            Text( "\(vm.qty)" )
                                .font(.customfont(.bold, fontSize: 24))
                                .foregroundColor(.primaryText)
                                .multilineTextAlignment(.center)
                                .frame(width: 45, height: 45, alignment: .center)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(  Color.placeholder.opacity(0.5), lineWidth: 1)
                                )
                            
                            Button {
                                vm.addSubQTY(isAdd: true)
                            } label: {
                                
                                Image( "add_green"  )
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .padding(10)
                            }
                            
                            Spacer()
                            
                            Text( "$\(  (pObj.offerPrice ?? pObj.price ?? 0.0) * Double(vm.qty) , specifier: "%.2f")"  )
                                .font(.customfont(.bold, fontSize: 28))
                                .foregroundColor(.primaryText)
                                
                        }
                        .padding(.vertical, 8)
                        
                        Divider()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    VStack{
                        HStack{
                            Text("Product Detail")
                                .font(.customfont(.semibold, fontSize: 16))
                                .foregroundColor(.primaryText)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            Button {
                                withAnimation {
                                    vm.showDetail()
                                }
                                
                            } label: {
                                
                                Image( vm.isShowDetail ? "detail_open" : "next"  )
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 15, height: 15)
                                    .padding(15)
                            }
                            .foregroundColor(Color.primaryText)

                        }
                        
                        if(vm.isShowDetail) {
                            Text(pObj.detail ?? "")
                                .font(.customfont(.medium, fontSize: 13))
                                .foregroundColor(.secondaryText)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.bottom , 8)
                        }
                        
                        
                        Divider()
                    }
                    .padding(.horizontal, 20)
                    
                    VStack{
                        HStack{
                            Text("Nutritions")
                                .font(.customfont(.semibold, fontSize: 16))
                                .foregroundColor(.primaryText)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                            
                            Text(pObj.nutritionWeight ?? "")
                                .font(.customfont(.semibold, fontSize: 10))
                                .foregroundColor(.secondaryText)
                                .padding(8)
                                .background( Color.placeholder.opacity(0.5) )
                                .cornerRadius(5)
                            
                            Button {
                                withAnimation {
                                    vm.showNutrition()
                                }
                                
                            } label: {
                                
                                Image( vm.isShowNutrition ? "detail_open" : "next"  )
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 15, height: 15)
                                    .padding(15)
                            }
                            .foregroundColor(Color.primaryText)

                        }
                        
                        if(vm.isShowNutrition) {
                            LazyVStack {
                                
                                ForEach( vm.nutritionArr , id: \.id) { nObj in
                                    HStack{
                                        Text( nObj.nutritionName ?? "" )
                                            .font(.customfont(.semibold, fontSize: 15))
                                            .foregroundColor(.secondaryText)
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        
                                        Text( nObj.nutritionValue ?? "")
                                            .font(.customfont(.semibold, fontSize: 15))
                                            .foregroundColor(.primaryText)
                                    }
                                    
                                    Divider()
                                }
                                .padding(.vertical, 0)
                               
                                
                            }
                            .padding(.horizontal, 10)
                        }
                        
                        
                        Divider()
                    }
                    .padding(.horizontal, 20)
                    
                    HStack{
                        Text("Review")
                            .font(.customfont(.semibold, fontSize: 16))
                            .foregroundColor(.primaryText)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        
                        HStack(spacing: 2){
                            ForEach( 1...5 , id: \.self) { index in
                                
                                Image(systemName:  "star.fill")
                                    .resizable()
                                    .scaledToFit()
                                        .foregroundColor( Color.orange)
                                        .frame(width: 15, height: 15)
                                    
                            }
                        }
                        
                        Button {
                           
                            
                        } label: {
                            
                            Image( "next" )
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .padding(15)
                        }
                        .foregroundColor(Color.primaryText)

                    }
                    .padding(.horizontal, 20)
                    
                    CustomBTN (title: "Add To Basket") {
                        vm.addToCart(prodId: pObj.prodId ?? 1, qty: vm.qty) { isDone, msg  in
                            
                            vm.qty = 1
                            
                            self.vm.alertMsg = msg
                            self.vm.alertError = true
                        }
                    }
                    .padding( 20)
                    
                }
                
                VStack {
                    
                    HStack{
                        Button {
                            mode.wrappedValue.dismiss()
                        } label: {
                            Image("back")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                        }
                        
                        Spacer()
                        
                        Button {
                        } label: {
                            Image("share")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25, height: 25)
                        }

                    }
                    
                    Spacer()
                }
                .padding(.top, .topInsets)
                .padding(.horizontal, 20)
                
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
