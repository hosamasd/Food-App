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
        return try await Network.POST_JSON(route: .Login, body: body)
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
