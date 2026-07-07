//
//  ExploreScene.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

struct ExploreScene: View {
    @StateObject var vm=ExploreViewModel()
    var colums =  [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    @State var txtSearch: String = ""

    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    
                    Spacer()
                    
                    Text("Find Products")
                        .font(.customfont(.bold, fontSize: 20))
                        .frame(height: 46)
                    Spacer()
                    
                }
                .padding(.top, .topInsets)
                
                SearchTextField(placholder: "Search Store", txt: $txtSearch)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 4)
                
                if(vm.listArr.count == 0) {
                    EmptyView(text: "no data founded")
                }
                ScrollView {
                    LazyVGrid(columns: colums, spacing: 20) {
                        ForEach(vm.listArr, id: \.id) {
                            cObj in
                            
                            NavigationLink(destination: ExploreItemsView(vm:vm,category:cObj ) ) {
                                ExploreCategoryCell(cObj: cObj)
                                    .aspectRatio( 0.95, contentMode: .fill)
                            }
                            
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .padding(.bottom, .bottomInsets + 60)
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
