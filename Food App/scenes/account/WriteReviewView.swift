//
//  WriteReviewView.swift
//  Food App
//
//  Created by hosam on 07/07/2026.
//

import SwiftUI

struct WriteReviewView: View {
    @StateObject var vm=WriteReviewViewModel()
    @State var txtMessage = ""
    @State var rating = 3
    
    var body: some View {
        ZStack{
            ZStack{
                ScrollView {
                    VStack(spacing: 15) {
                        
                        HStack(spacing: 15) {
                            ForEach(1...5, id: \.self) {
                                index in
                                
                                Image(systemName: "star.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor( index <= rating ? Color.orange : Color.black.opacity(0.2))
                                    .frame(width: .widthPer(per: 0.1), height: .widthPer(per: 0.1))
                                    .onTapGesture {
                                        rating = index
                                    }
                            }
                        }
                        
                        
                        ZStack(alignment: .leading, content: {
                            
                                TextEditor(text: $txtMessage)
                                .multilineTextAlignment(.leading)
                                .onAppear(){
                                    UITextView.appearance().backgroundColor = .clear
                                }
                            
                            VStack {
                                Text( txtMessage == "" ? "Write A Review here ..." : "" )
                                    .padding(8)
                                    .foregroundColor(.placeholder)
                                
                                Spacer()
                            }
                            
                        })
                        .padding(15)
                        .frame(minHeight: 300)
                        .background( Color.black.opacity(0.05) )
                        .cornerRadius(10)
                        .padding(.bottom, 15)
                        
                        CustomBTN(title: "Submit") {
                           
                        }
                       
                    }
                    .padding(20)
                    .padding(.top, .topInsets + 60)
                }
                
                TopHeaderView(title: "Write Review")
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
