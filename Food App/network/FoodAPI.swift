//
//  PaploAPI.swift
//  Publo Ultra
//
//
//

import Foundation
import SwiftUI

extension Bool {
    
}
let isiPad = UIDevice.current.userInterfaceIdiom == .pad

class FoodAPI {
    public static var shared = FoodAPI()
    
    func login(body:LoginPassModel)  async throws -> LoginResModel{
        return try await Network.POST_JSON(route: .Login, body: body)
    }
    
    func signUp(body:SignupPassModel)  async throws -> LoginResModel{
        return try await Network.POST_JSON(route: .signup, body: body)
    }
    
    func updateProfile(body:UpdateProfilePassModel)  async throws -> LoginResModel{
        return try await Network.POST_JSON(route: .updateProfile, body: body)
    }
    
    func forget(body:ForgetPassModel)  async throws -> LoginResModel{
        return try await Network.POST_JSON(route: .forget,auth:false, body: body)
    }
    
    func forget_verfiy(body:ForgetVerifyPassModel)  async throws -> LoginResModel{
        return try await Network.POST_JSON(route: .forget_verfiy,auth:false, body: body)
    }
    
    func forget_verfiy_setPass(body:ForgetVerifySetPassPassModel)  async throws -> LoginResModel{
        return try await Network.POST_JSON(route: .forgot_password_set_password,auth:false, body: body)
    }
    
    func getCarList(promo_code_id:Int,delivery_type:Int) async throws -> CartResModel {
            return try await Network.POST(route: .cart_list, body: ["promo_code_id":promo_code_id,"delivery_type":delivery_type])
        }
    

    func orderPlace(address_id:String,deliver_type:Int,payment_type:Int,pay_id:String,promo_code_id:Int) async throws -> CartResModel {
        return try await Network.POST(route: .orderPlace, body: ["address_id":address_id,"deliver_type":deliver_type,"payment_type":payment_type,"pay_id":pay_id,"promo_code_id":promo_code_id])
    }




func removeFromCart(cart_id:Int,prod_id:Int) async throws -> CartResModel {
        return try await Network.POST(route: .removeFromCart, body: ["cart_id":cart_id,"prod_id":prod_id])
    }

    func addToCart(prod_id:Int,qty:Int) async throws -> CartResModel {
            return try await Network.POST(route: .add_to_cart, body: ["prod_id":prod_id,"qty":qty])
        }
    func updateQty(cart_id:Int,prod_id:Int,new_qty:Int) async throws -> CartResModel {
        return try await Network.POST(route: .updateQty, body: ["cart_id":cart_id,"prod_id":prod_id,"new_qty":new_qty])
        }
    
    
    
    func getAddress()  async throws -> AddressResModel{
        return try await Network.POST(route: .getAddress, body: [:])
    }
    
    func exploreList()  async throws -> ExploreCategoryResModel{
        return try await Network.POST(route: .exploreList, body: [:])
    }
    
    func getProdcts(cat_id:Int)  async throws -> ProductResModel{
        return try await Network.POST(route: .getProdcts, body: ["cat_id":cat_id])
    }
    
    func addRemoveFav(prod_id:Int)  async throws -> ProductResModel{
        return try await Network.POST(route: .addRemoveFav, body: ["prod_id":prod_id])
    }
    
    
    func getPromoCode()  async throws -> PromoResModel{
        return try await Network.POST(route: .getPromoCode, body: [:])
    }
    
    func removeAddress(id:Int)  async throws -> AddressResModel{
        return try await Network.POST(route: .deleteAddres, body: ["address_id":id])
    }
    
    func addAddres(body:AddressSendModel)  async throws -> AddressResModel{
        return try await Network.POST_JSON(route: .addAddres,auth:false, body: body)
    }
    
    func updateAddres(body:AddressSendModel)  async throws -> AddressResModel{
        return try await Network.POST_JSON(route: .updateAddres,auth:false, body: body)
    }
    
    func readAllNotification()  async throws -> LoginResModel{
        return try await Network.POST(route: .readAllNotification, body: [:])
    }
    func getAllNotification()  async throws -> NotificationResModel{
        return try await Network.POST(route: .getAllNotification, body: [:])
    }
    func getFavorites()  async throws -> ProductResModel{
        return try await Network.POST(route: .getFavorites, body: [:])
    }
    
    func getHome()  async throws -> HomeModel{
        return try await Network.POST(route: .getHome, body: [:])
    }
    
    func getMyOrders()  async throws -> MyOrderResModel{
        return try await Network.POST(route: .getMyOrders, body: [:])
    }
    func payment_method()  async throws -> PaymentResModel{
        return try await Network.POST(route: .payment_method, body: [:])
    }
    func addPayment(body:PaymentAddModel)  async throws -> PaymentResModel{
        return try await Network.POST_JSON(route: .addPayment, body: body)
    }
    
    func my_order_detail(id:Int)  async throws -> MyOrderItemResModel{
        return try await Network.POST(route: .my_order_detail, body: ["order_id":id])
    }
    func removePayment(id:Int)  async throws -> PaymentResModel{
        return try await Network.POST(route: .removePayment, body: ["pay_id":id])
    }
    
    
    
    
//    func savePlanningVisit(body:VisitPlanSendRes) async throws -> VisitResModels {
//        return try await Network.POST_JSON(route: .savePlanningVisit, body: body)
//        
//    }
//    
//    func saveApprovalPlans(body:PlansAppSendRes) async throws -> VisitResModels {
//        return try await Network.POST_JSON(route: .saveApprovalPlans, body: body)
//        
//    }
//    
//    func uploadVisitImages(id:Int,data:[Data]) async throws -> VisitImageUploaded {
//        let body = ["address_id":"\(id)",
////                    "type":type,
//                    "delete_old_images":"true"
//        ]
//        return try await Network.UPLOAD3(route: .uploadVisitImages, fieldName: "images", extraFields: body, files: data)
//
////        return try await Network.UPLOADMultiImageSameTime(route: .addAddreesImage, fieldName: "images", extraFields: body, fileDataArray: data)
//
//    }
//    
//    func saveVisit(body:VisitSendRes) async throws -> VisitResModels {
//        //        func saveVisit(body:[String : Any]) async throws -> VisitResModels {
//        
//        return try await Network.POST_JSON(route: .saveVisit, body: body)
//        //        return try await Network.POST2(route: .saveVisit, body: body)
//        
//    }
//    
//    func updateLocation(body:LocationSends) async throws -> VisitResModels {
//        return try await Network.POST_JSON(route: .storeLocation, body: body)
//    }
//    
//    func saveVisit2(body:VisitSendRes) async throws -> VisitResModels {
//        //        func saveVisit2(body:[Visits]) async throws -> VisitResModel {
//        
//        return try await Network.POST_JSON(route: .saveVisit, body: body)
//        
//    }
//    
//    //    func saveVisit(body:[String:Any]) async throws -> VisitResModel {
//    //        return try await Network.POST(route: .saveVisit, body: body)
//    ////        return try await Network.POST_JSON(route: .saveVisit, body: body)
//    //
//    //    }
//    
//    
//    
//    func loginPIN(pin:String) async throws -> LoginPinResModel
//    {
//        return try await Network.GET(route: .LoginPIN(pin),auth: false)
//    }
//    
//    func masterData() async throws -> MasterDataResModel
//    {
//        return try await Network.GET(route: .masterData,auth: true)
//    }
//    
//    func getUserData() async throws -> UserResModel
//    {
//        return try await Network.GET(route: .user,auth: true)
//    }
//    
//    func getAccountDoctorData(lineId:[Int],divId:[Int]) async throws -> AccountAndDoctorsResModel
//    {
//        return try await Network.GET(route: .getAccountDoctor(lineId,divId),auth: true)
//    }
//    
//    //    func getPlannedVisitsData(body:PlannedReJSON) async throws -> PlannedRepResModel
//    //    func getPlannedVisitsData(lineId:[Int],divId:[Int]) async throws -> PlannedRepResModel
//    //
//    //    {
//    func getPlannedVisitsData() async throws -> PlannedRepResModel
//    
//    {
//        return try await Network.GET(route: .getPlannedVisitsData,auth: true)
//    }
//    func getPendingApprovalData() async throws -> PlanApproResS
//    
//    {
//        return try await Network.GET(route: .getPendingApprovalData,auth: true)
//    }
//    
//    
//    func getPresentaitonsData() async throws -> GetPresentaionResponse
//    
//    {
//        return try await Network.GET(route: .getPresentaitonsData,auth: true)
//        
//    }
//    
//    
//    
//    func saveOW(body:OWModelSeMain) async throws -> OWModelRESss
//    {
//        return try await Network.POST_JSON(route: .saveOW, body: body)
//    }
//    func checkInOut(body:[CheckInOutSend]) async throws -> CheckInOutRess
//    {
//        return try await Network.POST_JSON(route: .checkInOut, body: body)
//    }
//    
//    func loadOW() async throws -> OWresplnseModel
//    {
//        return try await Network.GET(route: .loadOW,auth: true)
//    }
//    
//    func clarify(body:ClarifySend) async throws -> OWresplnseModel
//    {
//        return try await Network.POST_JSON(route: .clarify, body: body)
//    }
//    
//    
//    
//    
//    func getPresentations(FN:String="GetPresentations",teamId:Int=1) async throws -> getPresentationsResModel
//    {
//        return try await Network.GET(route: .getPresentations(FN,teamId),auth: true)
//    }
//    
//    func loadActualVisit(body:loadActualVisitSendModel) async throws -> getPresentationsResModel
//    {
//        return try await Network.POST_JSON(route: .loadActualVisit, body: body)
//    }
//    
//    func loadOW(body:loadActualVisitSendModel) async throws -> getPresentationsResModel
//    {
//        return try await Network.POST_JSON(route: .Login, body: body)
//    }
    
    
    //    func login(body:[String:Any]) async throws -> LoginModel
    //    {
    ////        var body = ["username":"rayedbiz@gmail.com","password":"12345678"]
    //        //,"device_token" : "asd", "device_type" : "1", "uuid" : UUID().uuidString, "os_version" : "16", "device_name" : "iPhone", "model_name" : "iPhone X", "build_version_number" : "1"]
    //
    ////        var body = ["username":"rayedbiz@gmail.com","password":"12345678"]//,"device_token" : "asd", "device_type" : "1", "uuid" : UUID().uuidString, "os_version" : "16", "device_name" : "iPhone", "model_name" : "iPhone X", "build_version_number" : "1"]
    //        return try await Network.POST(route: .Login, auth: false, body: body)
    //
    //
    //    }
    //
    //    func getProfile() async throws -> MercantProductsModel
    //    {
    ////        var body = ["username":"rayedbiz@gmail.com","password":"12345678"]
    //        return try await Network.GET(route: .Profile,auth: true)
    //    }
    //
    //    //MARK: -places
    //    func PlaceData(id:Int) async throws -> PlaceDataModel
    //    {
    //        return try await Network.GET(route: .PlaceData(id),auth: true)
    //    }
    //
    //    func addPlace(product:AddProductModels) async throws -> AddPlaceModel {
    //
    //        return try await Network.POST_JSON(route: .AddPlace, auth: true, body: product)
    //    }
    //
    //    func updatePlace(id:Int,product:AddProductModels) async throws -> AddPlaceModel {
    //
    //        return try await Network.PUT_JSON(route: .EditPlace(id), auth: true, body: product)
    //    }
    //
    //    func addPlaceImage(id:Int,data:Data,isSlider:Bool=true) async throws -> ProductImageUploaded {
    //        let body = ["type":isSlider ? "slider" : "menu"]
    //        return try await Network.UPLOAD2(route: .AddPlaceImage(id), fieldName: "image", extraFields: body, fileData: data)
    //    }
    //
    //
    //
    //    func removePlaceImage(id:Int,id2:Int) async throws -> ImageRemovedSucc
    //    {
    //        return try await Network.DELETE(route: .RemovePlaceImage(id,id2),auth: true)
    //    }
    //    func myPlacesIDTitle() async throws -> OfferPlaces
    //    {
    //        return try await Network.DELETE(route: .MyPlacesIdTitle,auth: true)
    //    }
    //
    //
    //
    //    //MARK: -offers
    //
    //    func getOffers() async throws -> OffersModel
    //    {
    ////        var body = ["username":"rayedbiz@gmail.com","password":"12345678"]
    //        return try await Network.GET(route: .Offers,auth: true)
    //    }
    //
    //    func addOfferImage(id:Int,data:Data) async throws -> OfferImageUploaded
    //    {
    //        return try await Network.UPLOAD2(route: .AddOfferImage(id), fieldName: "image", extraFields: [:], fileData: data)
    ////        return try await Network.GET(route: .AddOfferImage(id),auth: true)
    //    }
    //
    //    func addOffer(offer:AddOfferSend) async throws -> AddedOfferModel
    //    {
    //        return try await Network.POST_JSON(route: .AddOffer,auth: true,body: offer)
    //    }
    
    //    func checks() async throws -> PlaceDataModel {
    //        //https://maps.googleapis.com/maps/api/place/autocomplete/json?input=egypt&key=AIzaSyAcmjU9Dtvs-vOETYHmWXpt7wxb1bJhUAw
    //        return try await Network.GET(route: .def,auth: true)
    //
    //    }
    
    
    
    
    //    func login() async throws -> [Bike]
    //    {
    //
    //        return try await Network.GET(route: .FetchBikes,auth: false)
    //    }
    
}
