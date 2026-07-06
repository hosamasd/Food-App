//
//  Network.swift
//  ArabicBiker
//
//  Created by RAYED AL NOOM on 13/12/2022.
//

import Foundation
import SwiftUI
struct LaravelErrorResponse: Decodable
{
    let message: String
}




var timeoutVal:TimeInterval = 90

class Network {
    


//public static var urlBase: String = "http://localhost:3001/api/admin/"
    public static var urlBase: String = "http://localhost:3001/api/app/"


    public enum NetworkError: Error {
        case invalidateSession(String)
        case notAutherized
        case serverError(LaravelErrorResponse)
        case invalidResponse(Int, String)
        case connectivity
        case decodingError(Error, Data, Int?)
        case timeout

    }
    
    
    
    public enum APIs  {
        public static var Login = "login"
        public static var signup = "sign_up"
        public static var forget = "forgot_password_request"
        public static var forget_verfiy = "forgot_password_verify"
        public static var forgot_password_set_password = "forgot_password_set_password"
        public static var updateProfile = "update_profile"
        public static var readAllNotification = "notification_read_all"
        public static var getAllNotification = "notification_list"

        
        
        
        public static var saveVisit = "save-actuals"
        public static var storeLocation = "store_location"

        
        public static var savePlanningVisit = "save-plan"
        public static var saveApprovalPlans = "save-approved-plans"
        public static var uploadVisitImages = "save-approved-plans"

        
        
        public static var saveOW = "save-ow"
        public static var loadOW = "plan-ows"
        public static var checkInOut = "v2/store_check_in_outs"

        
        
        
//        public static var saveVisit = "https://pulpo.pulposoft.net/api/save-actuals"

    
        
        public static var LoginPIN = "https://app.pulpopharma.online/itg_pulpoultra/android/index.php?FN=master&pin={pin}"

        
        
        
        public static var masterData =  "master-data"
        public static var user = "user"
        public static var getAccountDoctor = "accounts-doctors?lineId={id}&divId={id2}"
//        public static var getPlannedVisitsData = "plan-visits"
//        public static var getPlannedVisitsData = "plan-visits?lineId={id}&divId={id2}"
//        public static var getPlannedVisitsData = "plan-visits?lineId={id}&divId={id2}"
        public static var getPlannedVisitsData = "plan-visits"
        public static var getPendingApprovalData = "pending-plan-visits"

        
        public static var getPresentaitonsData = "app-presentations"

        
        public static var getPresentations = "https://pulpo-cira.cloud/itg_pulpoultra_cira/android/index.php?FN={FN}&teamId={id2}"

        public static var loadActualVisit = "save-actuals"

        
        public static var AddPlace = "/places"
        public static var EditPlace = "/places/{id}"

        public static var MyPlacesIdTitle =  "/places/my_places_id_title"
        public static var AddPlaceImage = "/places/{id}/image"
        public static var AddOffer = "/offers"
        public static var AddOfferImage =  "/offers/{id}/image"
        public static var Offers = "/offers/mine"
        public static var clarify = "plan-clarification"

        
        
        
        
        public static var RefreshUserData = "/offers/{id}/image"
                
        public static var LockStatus = "/api/lock_status/{qr}"
        
        public static var Tour = "/api/tours"
        public static var TourUnlockRequest = "/api/tours/tour_unlock_request"
        public static var TourEnd = "/api/tours/{id}/end"
                
                
        public static var TestingBody = "/api/testing_body/{id}"
    }
    
 
    
    public enum Routes
    {
        case Login
        case signup
        case forget
        case forget_verfiy
        case forgot_password_set_password
        case updateProfile
        case readAllNotification
        case getAllNotification
        
        
        case saveApprovalPlans
        case uploadVisitImages

        
        
        
        case LoginPIN(String)

        case masterData
        case user
        case getAccountDoctor([Int],[Int])
        case getPlannedVisitsData
        case getPendingApprovalData

        
        case getPresentaitonsData

        
//        case getPlannedVisitsData(Int,Int)
//        case getPlannedVisitsData([Int],[Int])

        case getPresentations(String,Int)
        case loadActualVisit

        case saveOW
        case loadOW
        case checkInOut
        case clarify
        
        
        
        case AddPlace
        case EditPlace(Int)
        case AddPlaceImage(Int)
        case AddOffer
        case AddOfferImage(Int)
        case Offers

        case MyPlacesIdTitle
//        case LockCheck(String)
//        case LockStatus(String)
//        case TourUnlockRequest
//        case TourEnd(Double)
//        case TestingBody(Int)
//        case def
        
        func url() -> String {
            switch self {
//            case .def:
//                return "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=egypt&key=AIzaSyAcmjU9Dtvs-vOETYHmWXpt7wxb1bJhUAw"
            case .Login:
                return Network.urlBase + APIs.Login
            case .signup:
                return Network.urlBase + APIs.signup
            case .forget:
                return Network.urlBase + APIs.forget
            case .forget_verfiy:
                return Network.urlBase + APIs.forget_verfiy
            case .forgot_password_set_password:
                return Network.urlBase + APIs.forgot_password_set_password
            case .updateProfile:
                return Network.urlBase + APIs.updateProfile
            case .readAllNotification:
                return Network.urlBase + APIs.readAllNotification
            case .getAllNotification:
                return Network.urlBase + APIs.getAllNotification
                
                
            case .saveApprovalPlans:
                return Network.urlBase + APIs.saveApprovalPlans
            case .uploadVisitImages:
                return Network.urlBase + APIs.uploadVisitImages
                
            case .saveOW:
                return Network.urlBase + APIs.saveOW
            case .checkInOut:
                return Network.urlBase + APIs.checkInOut
                
            case .loadOW:
                return Network.urlBase + APIs.loadOW
                
            case .LoginPIN(let  pin):
                return  APIs.LoginPIN.replacingOccurrences(of: "{pin}", with: "\(pin)")
                
                
            case .masterData:
                return Network.urlBase + APIs.masterData
            case .user:
                return Network.urlBase + APIs.user
            case .getAccountDoctor(let id,let id2):
                return Network.urlBase + APIs.getAccountDoctor.replacingOccurrences(of: "{id}", with: "\(id)").replacingOccurrences(of: "{id2}", with: "\(id2)")
            case .getPlannedVisitsData:
                return Network.urlBase + APIs.getPlannedVisitsData
            case .getPendingApprovalData:
                return Network.urlBase + APIs.getPendingApprovalData
                
            case .getPresentaitonsData:
                return Network.urlBase + APIs.getPresentaitonsData
                
//            case .getPlannedVisitsData(let id,let id2):
//                return Network.urlBase + APIs.getPlannedVisitsData.replacingOccurrences(of: "{id}", with: "\(id)").replacingOccurrences(of: "{id2}", with: "\(id2)")
            case .getPresentations(let FN,let id2):
//                return Network.urlBase +
                return APIs.getPresentations.replacingOccurrences(of: "{FN}", with: "\(FN)").replacingOccurrences(of: "{id2}", with: "\(id2)")
            case .loadActualVisit:
                return Network.urlBase + APIs.loadActualVisit
           
                
                
                
                
            case .AddPlaceImage(let  id):
                return Network.urlBase + APIs.AddPlaceImage.replacingOccurrences(of: "{id}", with: "\(id)")
           
            case .AddOffer:
                return Network.urlBase + APIs.AddOffer
            case .AddOfferImage(let id):
                return Network.urlBase + APIs.AddOfferImage.replacingOccurrences(of: "{id}", with: "\(id)")
            case .MyPlacesIdTitle:
                return Network.urlBase + APIs.MyPlacesIdTitle
            case .EditPlace(let id):
                return Network.urlBase + APIs.EditPlace.replacingOccurrences(of: "{id}", with: "\(id)")
            case .Offers:
                return Network.urlBase + APIs.Offers
            case .clarify:
                return Network.urlBase + APIs.clarify
                
//            case .LockCheck(let qr):
//                return Network.urlBase + APIs.LockCheck.replacingOccurrences(of: "{qr}", with: qr)
//            case .LockStatus(let qr):
//                return Network.urlBase + APIs.LockStatus.replacingOccurrences(of: "{qr}", with: qr)
          
//            case .TourUnlockRequest:
//                return Network.urlBase + APIs.TourUnlockRequest
//            case .TourEnd(let id):
//                return Network.urlBase + APIs.TourEnd.replacingOccurrences(of: "{id}", with: "\(id)")
//            case .TestingBody(let id):
//                return Network.urlBase + APIs.TestingBody.replacingOccurrences(of: "{id}", with: "\(id)")
            case .AddPlace:
                return Network.urlBase + APIs.AddPlace

            }
        }
    }
    

    public enum HTTPMethods: String
    {
        case GET
        case DELETE
        case JSON_POST
        case PUT
        case POST
    }
    
    public enum NetwokrActionStatus: Equatable
    {

        
        case notReady
        case idle
        case busy
        case error(NetworkError)
        
        
        public static func == (lhs: Network.NetwokrActionStatus, rhs: Network.NetwokrActionStatus) -> Bool {
            switch rhs {
            case .error(_):
                if case .error(_) = lhs {
                    return true
                }
            default:
                return rhs == lhs
            }
            
            return false
        }
    }
    
    public static func withTimeout<T>(timeout: TimeInterval, operation: @escaping () async throws -> T) async throws -> T {
        try await withThrowingTaskGroup(of: T.self) { group in
            group.addTask {
                try await operation()
            }
            
            group.addTask {
                try await Task.sleep(nanoseconds: UInt64(timeout * 1_000_000_000))
                throw NetworkError.timeout
            }
            
            guard let result = try await group.next() else {
                throw NetworkError.timeout
            }
            
            group.cancelAll()
            
            return result
        }
    }
    
    private static func makeRequest(route: Routes, method: HTTPMethods, auth: Bool = true,isPut:Bool = false) throws -> URLRequest
    {
        @AppStorage("UserToken") var UserToken: String = ""
        @AppStorage("cachedUserToken") var cachedUserToken: String = ""

//        let session: Session = Session.shared
        var q = route.url()
//        if !q.contains("http"){
//                q=cachedUserToken+q
//        }

        let encodedLink = q.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? ""
        
//        var request = URLRequest(url: URL(string: route.url())!)
        var request = URLRequest(url:  URL(string: encodedLink)!  ) //: route.url())!)

        // laravel

//        request.setValue("XMLHttpRequest", forHTTPHeaderField: "X-Requested-With")
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        request.setValue("b7dcbb3bee57ed51b8bcc5e4ec8dd62a", forHTTPHeaderField: "x-auth-app-token")

        
        
//        request.setValue(UUID().uuidString, forHTTPHeaderField: "Postman-Token")

        if method == .JSON_POST || method == .POST //|| method == .JSON_PUT
        {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = HTTPMethods.POST.rawValue //isPut ? HTTPMethods.JSON_PUT.rawValue :  HTTPMethods.POST.rawValue
//            request.httpMethod
        }
        else
        {
            request.httpMethod = method.rawValue
        }
        
        

        if auth {
           
//            guard session.customer != nil else {
//                throw NetworkError.invalidateSession("Local session is invalid can't make auth request")
//            }
            
//            request.setValue("\(session.customer!.accessToken)" , forHTTPHeaderField: "x-auth-token")
            let cacheUser: LocalJSONStore<UserModel> = LocalJSONStore(storageType: .cache, filename: "UserModel.json")
            let access_token = "jd6lMJhd6sLLR6cCfjhK"//cacheUser.storedValue?.authToken ?? 
//            let access_token = cacheUser.storedValue?.authToken ?? "8F9WIG9MwqcTJkpkRXrP"

            request.setValue(access_token , forHTTPHeaderField: "access_token")

            
            
        }
      
        return request
        
    }
    
    public static func UPLOAD2<T: Decodable>(route: Routes, auth: Bool = true, fieldName: String, extraFields: [String: String], fileData: Data,fileExtension: String = "png") async throws -> T {
        
        var request = try makeRequest(route: route, method: .POST, auth: auth)
                 
                 let boundary = "Boundary-\(UUID().uuidString)"
                 request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                 
                 
                 
                 
                 var httpBody: Data = Data()
                 
                 // Additional fields
                 for field in extraFields{
                     httpBody.append("--\(boundary)\r\n".data(using: .utf8)!)
                     httpBody.append("Content-Disposition:form-data; name=\"\(field.key)\"\r\n\r\n".data(using: .utf8)!)
                     httpBody.append(field.value.data(using: .utf8)!)
                     httpBody.append("\r\n".data(using: .utf8)!)
                 }
                 
                 
                 
                 httpBody.append("--\(boundary)\r\n".data(using: .utf8)!)
                 httpBody.append("Content-Disposition:form-data; name=\"\(fieldName)\"; filename=\"\(fieldName).\(fileExtension)\"\r\n".data(using: .utf8)!)
                 httpBody.append("Content-Type: image/\(fileExtension)\r\n\r\n".data(using: .utf8)!)
                 httpBody.append(fileData)
                 httpBody.append("\r\n".data(using: .utf8)!)
                 httpBody.append("--\(boundary)--".data(using: .utf8)!)
                 
                 request.httpBody = httpBody
                 
                 
                 let (data, urlResponse) = try await withTimeout(timeout: timeoutVal) {
            try await URLSession.shared.data(for: request)
        }
                 
                 return try Network.makeResponse(data: data, urlResponse: urlResponse)
    }

    private static func makeResponse<T: Decodable>(data: Data, urlResponse: URLResponse) throws -> T
    {
        if let resp  = urlResponse as? HTTPURLResponse
        {
            
//            print(String(data: data, encoding: .utf8))
            
            if (200..<300).contains(resp.statusCode)
            {
                
                
                do {
                                    
                    return try JSONDecoder().decode(T.self, from: data)
                }
                catch(let error)
                {
                    print("docoding issue \(error.localizedDescription)")
                    throw NetworkError.decodingError(error, data, resp.statusCode)
                }
                
                
                
                    
            }
            else
            {
                if resp.statusCode == 401
                {
                    Task{@MainActor in
//                        Session.shared.customer = nil
//                        Session.shared.save()
                    }

                    
                    throw NetworkError.notAutherized
                }
                
                
                if let error = try? JSONDecoder().decode(LaravelErrorResponse.self, from: data)
                {
                    throw NetworkError.serverError(error)
                }
                
                throw NetworkError.invalidResponse(resp.statusCode, String(data: data, encoding: .utf8) ?? "no data")
            }
        }
        
        throw NetworkError.connectivity
    }
    
    
    public static func GET<T: Decodable>(route: Routes, auth: Bool = true) async throws -> T {
        

        let request = try makeRequest(route: route, method: .GET, auth: auth)
        let (data, urlResponse) = try await withTimeout(timeout: timeoutVal) {
            try await URLSession.shared.data(for: request)
        }
            
        return try Network.makeResponse(data: data, urlResponse: urlResponse)
 
    }
    
    public static func GETSec<T: Decodable, B: Encodable>(route: Routes, auth: Bool = true,body: B) async throws -> T {
        

        var request = try makeRequest(route: route, method: .GET, auth: auth)
        request.httpBody = try JSONEncoder().encode(body)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        let (data, urlResponse) = try await withTimeout(timeout: timeoutVal) {
            try await URLSession.shared.data(for: request)
        }
            
        return try Network.makeResponse(data: data, urlResponse: urlResponse)
 
    }
    
    public static func DELETE<T: Decodable>(route: Routes, auth: Bool = true) async throws -> T {
        

        let request = try makeRequest(route: route, method: .DELETE, auth: auth)
        let (data, urlResponse) = try await withTimeout(timeout: timeoutVal) {
            try await URLSession.shared.data(for: request)
        }
            
        return try Network.makeResponse(data: data, urlResponse: urlResponse)
 
    }
    
    public static func POST<T: Decodable, B: Encodable>(route: Routes, auth: Bool = true, body: B?) async throws -> T {
     
        var request = try makeRequest(route: route, method: .POST, auth: auth)
        
        let encoder = JSONEncoder()
           encoder.outputFormatting = .prettyPrinted
        if let body {
            request.httpBody = try encoder.encode(body)//JSONEncoder().encode(body)
        }
        
        let (data, urlResponse) = try await withTimeout(timeout: timeoutVal) {
            try await URLSession.shared.data(for: request)
        }
            
        return try Network.makeResponse(data: data, urlResponse: urlResponse)
        
    }
    
    public static func UPLOAD3<T: Decodable>(
        method: HTTPMethods = .POST,
        route: Routes,
        auth: Bool = true,
        fieldName: String,
        extraFields: [String: String],
        files: [Data],
        fileExtension: String = "png",
        timeoutInterval: TimeInterval = timeoutVal
    ) async throws -> T {
        
        var request = try makeRequest(route: route, method: method, auth: auth)
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var httpBody = Data()
        
        // Append extra fields
        for (key, value) in extraFields {
            httpBody.append("--\(boundary)\r\n".data(using: .utf8)!)
            httpBody.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            httpBody.append("\(value)\r\n".data(using: .utf8)!)
        }
        
        // Append multiple image files
        for (index, fileData) in files.enumerated() {
            httpBody.append("--\(boundary)\r\n".data(using: .utf8)!)
            httpBody.append("Content-Disposition: form-data; name=\"\(fieldName)[\(index)]\"; filename=\"\(fieldName)_\(index).\(fileExtension)\"\r\n".data(using: .utf8)!)
            httpBody.append("Content-Type: image/\(fileExtension)\r\n\r\n".data(using: .utf8)!)
            httpBody.append(fileData)
            httpBody.append("\r\n".data(using: .utf8)!)
        }
        
        httpBody.append("--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = httpBody
        
        let (data, urlResponse) = try await withTimeout(timeout: timeoutInterval) {
            try await URLSession.shared.data(for: request)
        }
        
        return try Network.makeResponse(data: data, urlResponse: urlResponse)
    }
    
    public static func UPLOADMultiImageSameTime<T: Decodable>(
        method: HTTPMethods = .POST,
        route: Routes,
        auth: Bool = true,
        fieldName: String,
        extraFields: [String: String],
        fileDataArray: [Data],
        timeoutInterval: TimeInterval = timeoutVal
    ) async throws -> T {
        var request = try makeRequest(route: route, method: method, auth: auth)
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var httpBody = Data()
        
        // Add extra fields first
        for (key, value) in extraFields {
            httpBody.append("--\(boundary)\r\n")
            httpBody.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            httpBody.append(value)
            httpBody.append("\r\n")
        }
        
        // Create images array first
        let imagesMetadata = fileDataArray.map { fileData -> [String: String] in
            let fileName = "compressed_\(Int.random(in: 1000000000...9999999999)).jpg"
            let sizeInKB = Double(fileData.count) / 1024.0
            return [
                "name": fileName,
                "size": "\(String(format: "%.3f", sizeInKB))KB"
            ]
        }
        
        // Add image files using the same filenames
        for (index, fileData) in fileDataArray.enumerated() {
            let fileName = imagesMetadata[index]["name"] ?? ""
            
            httpBody.append("--\(boundary)\r\n")
            httpBody.append("Content-Disposition: form-data; name=\"\(fieldName)[]\"; filename=\"\(fileName)\"\r\n")
            httpBody.append("Content-Type: image/jpeg\r\n\r\n")
            httpBody.append(fileData)
            httpBody.append("\r\n")
        }
        
        httpBody.append("--\(boundary)--\r\n")
        request.httpBody = httpBody
        
        let (data, urlResponse) = try await withTimeout(timeout: timeoutInterval) {
            try await URLSession.shared.data(for: request)
        }
        
        return try Network.makeResponse(data: data, urlResponse: urlResponse)
    }


    
    public static func UPLOAD2<T: Decodable>(method: HTTPMethods = .POST, route: Routes, auth: Bool = true, fieldName: String, extraFields: [String: String], fileData: Data, fileExtension: String = "png", timeoutInterval: TimeInterval = timeoutVal) async throws -> T {
        
        var request = try makeRequest(route: route, method: method, auth: auth)
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var httpBody: Data = Data()
        
        // Additional fields
        for field in extraFields {
            httpBody.append("--\(boundary)\r\n".data(using: .utf8)!)
            httpBody.append("Content-Disposition: form-data; name=\"\(field.key)\"\r\n\r\n".data(using: .utf8)!)
            httpBody.append("\(field.value)\r\n".data(using: .utf8)!)
        }
        
        httpBody.append("--\(boundary)\r\n".data(using: .utf8)!)
        httpBody.append("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fieldName).\(fileExtension)\"\r\n".data(using: .utf8)!)
        httpBody.append("Content-Type: image/\(fileExtension)\r\n\r\n".data(using: .utf8)!)
        httpBody.append(fileData)
        httpBody.append("\r\n".data(using: .utf8)!)
        httpBody.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = httpBody
        


            let (data, urlResponse) = try await withTimeout(timeout: timeoutInterval) {
                try await URLSession.shared.data(for: request)
            }
            
            return try Network.makeResponse(data: data, urlResponse: urlResponse)

    }
 
    public static func POST_JSON<T: Decodable, B: Encodable>(route: Routes, auth: Bool = true, body: B) async throws -> T {
     
        var request = try makeRequest(route: route, method: .JSON_POST, auth: auth)
        
       
            request.httpBody = try JSONEncoder().encode(body)
        
//        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let (data, urlResponse) = try await withTimeout(timeout: timeoutVal) {
            try await URLSession.shared.data(for: request)
        }
            
        
        return try Network.makeResponse(data: data, urlResponse: urlResponse)
        
    }
    
    public static func POST_WITHOUTBODY<T: Decodable, B: Encodable>(route: Routes, auth: Bool = true, body: B) async throws -> T {

   
            
        var request = try makeRequest(route: route, method: .POST, auth: auth)

        let (data, urlResponse) = try await withTimeout(timeout: timeoutVal) {
            try await URLSession.shared.data(for: request)
        }

            
            return try Network.makeResponse(data: data, urlResponse: urlResponse)

    }
    
    public static func PUT_JSON<T: Decodable, B: Encodable>(route: Routes, auth: Bool = true, body: B) async throws -> T {
     
        var request = try makeRequest(route: route, method: .PUT, auth: auth,isPut: true)
        
        
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, urlResponse) = try await withTimeout(timeout: timeoutVal) {
            try await URLSession.shared.data(for: request)
        }
            
        return try Network.makeResponse(data: data, urlResponse: urlResponse)
        
    }
    
    public static func POST<T: Decodable>(route: Routes, auth: Bool = true, body: [String: Any]) async throws -> T {
     
        var request = try makeRequest(route: route, method: .JSON_POST, auth: auth)
        
        request.httpBody =  try JSONSerialization.data(withJSONObject: body, options: [])
        
        let (data, urlResponse) = try await withTimeout(timeout: timeoutVal) {
            try await URLSession.shared.data(for: request)
        }
            
        return try Network.makeResponse(data: data, urlResponse: urlResponse)
        
    }
    
    public static func POST2<T: Decodable>(route: Routes, auth: Bool = true, body: [String: Any]) async throws -> T {
     
        var request = try makeRequest(route: route, method: .POST, auth: auth)
        
        request.httpBody =  try JSONSerialization.data(withJSONObject: body, options: [])
        
        let (data, urlResponse) = try await withTimeout(timeout: timeoutVal) {
            try await URLSession.shared.data(for: request)
        }
            
        return try Network.makeResponse(data: data, urlResponse: urlResponse)
        
    }
    
    
    

}
extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
