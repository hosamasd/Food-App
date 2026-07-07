////
////  AddDeliveryAddressView.swift
////  Food App
////
////  Created by hosam on 07/07/2026.
////
//
//import SwiftUI
//
//struct AddDeliveryAddressView: View {
//    @Environment(\.presentationMode) var mode : Binding<PresentationMode>
//    @ObservedObject var vm:DelieryAddressViewModel
//    @State var isEdit: Bool = false
//    @State var editObj: AddressModel?
//    
//    var body: some View {
//        
//       
//        
//        ZStack{
//            
//            ZStack{
//                ScrollView{
//                    VStack(spacing: 15){
//                        
//                        HStack{
//                            
//                            Button {
//                                vm.txtTypeName = "Home"
//                            } label: {
//                                Image(systemName: vm.txtTypeName == "Home" ? "record.circle" : "circle"  )
//                                
//                                Text("Home")
//                                    .font(.customfont(.medium, fontSize: 16))
//                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
//                            }
//                            .foregroundColor(.primaryText)
//                            
//                            Button {
//                                vm.txtTypeName = "Office"
//                            } label: {
//                                Image(systemName: vm.txtTypeName == "Office" ? "record.circle" : "circle"  )
//                                
//                                Text("Office")
//                                    .font(.customfont(.medium, fontSize: 16))
//                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading )
//                            }
//                            .foregroundColor(.primaryText)
//                            
//                            
//                        }
//                        
//                        CustomTextField(title: "Name Line",hint:"Enter you name",text:$vm.txtName, type:.default,isPassField: .constant(false) )
//                        
//                        CustomTextField(title: "Mobile Line",hint:"Enter you mobile number",text:$vm.txtMobile, type:.numberPad,isPassField: .constant(false) )
//                        
//                        CustomTextField(title: "Address Line",hint:"Enter you address",text:$vm.txtAddress, type:.default,isPassField: .constant(false) )
//                        HStack{
//                            CustomTextField(title: "City",hint:"Enter you city",text:$vm.txtCity, type:.default,isPassField: .constant(false) )
//                            CustomTextField(title: "State",hint:"Enter you state",text:$vm.txtState, type:.default,isPassField: .constant(false) )
//                        }
//                        
//                        
//                        CustomTextField(title: "Postal Code",hint:"Enter you postal code",text:$vm.txtPostalCode, type:.default,isPassField: .constant(false) )
//                        
//                        
//                        CustomBTN (title: isEdit ? "Update Address" : "Add Address") {
//                            if(isEdit) {
//                                vm.updateAddres(address:editObj){
//                                    self.mode.wrappedValue.dismiss()
//                                }
//                                
//                            }else{
//                                vm.addAddress(didDone: {
//                                    self.mode.wrappedValue.dismiss()
//
//                                })
//                            }
//                        }
//                    }
//                    
//                    
//                    .padding(20)
//                    .padding(.top, .topInsets + 46)
//                    
//                }
//                
//                VStack {
//                    
//                    HStack{
//                        
//                        Button {
//                            mode.wrappedValue.dismiss()
//                        } label: {
//                            Image("back")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 20, height: 20)
//                        }
//                        
//                        
//                        
//                        Spacer()
//                        
//                        Text( isEdit ? "Edit Delivery Address" : "Add Delivery Address")
//                            .font(.customfont(.bold, fontSize: 20))
//                            .frame(height: 46)
//                        Spacer()
//                        
//                        
//                        
//                    }
//                    .padding(.top, .topInsets)
//                    .padding(.horizontal, 20)
//                    .background(Color.white)
//                    .shadow(color: Color.black.opacity(0.2),  radius: 2 )
//                    
//                    Spacer()
//                    
//                }
//                
//                if vm.isLoading{
//                    ArcView()
//                }
//            }
//            .onAppear{
//                if(isEdit) {
//                    if let aObj = editObj {
//                        vm.setData(aObj: aObj)
//                    }
//                }
//            }
//            .navigationTitle("")
//            .navigationBarHidden(true)
//            .navigationBarBackButtonHidden(true)
//            .ignoresSafeArea()
//            .overlay(overlayView: Toasts.init(dataModel: Toasts.ToastDataModel.init(title: vm.alertMsg, image: "checkmark"), show: $vm.alert)
//                     , show: $vm.alert)
//            .alert(
//                isPresented: $vm.alertError,
//                content: { Alert(title: Text(LocalizedStringKey(vm.alertMsg))) })
//        }
//    }
//}
