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
        public static var getMyOrders = "my_order"
        public static var my_order_detail = "my_order_detail"
        public static var payment_method = "payment_method"
        public static var removePayment = "remove_payment_method"
        public static var addPayment = "add_payment_method"
        public static var getAddress = "delivery_address"
        public static var addAddres = "add_delivery_address"
        public static var updateAddres = "update_delivery_address"
        public static var deleteAddres = "delete_delivery_address"
        public static var cart_list = "cart_list"
        public static var add_to_cart = "add_to_cart"
        public static var removeFromCart = "remove_cart"
        public static var orderPlace = "order_place"
        public static var updateQty = "update_cart"
        public static var getPromoCode = "promo_code_list"
        public static var exploreList = "explore_category_list"
        public static var getProdcts = "explore_category_items_list"
        public static var addRemoveFav = "add_remove_favorite"
        public static var getFavorites = "favorite_list"
        public static var getHome = "home"

        
        
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
        case getMyOrders
        case my_order_detail
        case payment_method
        case removePayment
        case addPayment
        case getAddress
        case addAddres
        case updateAddres
        case deleteAddres
        case cart_list
        case add_to_cart
        case removeFromCart
        case orderPlace
        case updateQty
        case getPromoCode
        case exploreList
        case getProdcts
        case addRemoveFav
        case getFavorites
        case getHome
       
        
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
            case .getMyOrders:
                return Network.urlBase + APIs.getMyOrders
            case .my_order_detail:
                return Network.urlBase + APIs.my_order_detail
            case .payment_method:
                return Network.urlBase + APIs.payment_method
            case .removePayment:
                return Network.urlBase + APIs.removePayment
            case .addPayment:
                return Network.urlBase + APIs.addPayment
            case .getAddress:
                return Network.urlBase + APIs.getAddress
            case .deleteAddres:
                return Network.urlBase + APIs.deleteAddres
            case .updateAddres:
                return Network.urlBase + APIs.updateAddres
            case .addAddres:
                return Network.urlBase + APIs.addAddres
            case .cart_list:
                return Network.urlBase + APIs.cart_list
            case .add_to_cart:
                return Network.urlBase + APIs.add_to_cart
            case .removeFromCart:
                return Network.urlBase + APIs.removeFromCart
            case .orderPlace:
                return Network.urlBase + APIs.orderPlace
            case .updateQty:
                return Network.urlBase + APIs.updateQty
            case .getPromoCode:
                return Network.urlBase + APIs.getPromoCode
            case .exploreList:
                return Network.urlBase + APIs.exploreList
            case .getProdcts:
                return Network.urlBase + APIs.getProdcts
            case .addRemoveFav:
                return Network.urlBase + APIs.addRemoveFav
            case .getFavorites:
                return Network.urlBase + APIs.getFavorites
            case .getHome:
                return Network.urlBase + APIs.getHome
                
                
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
    private static func makeRequest2(route: Routes, method: HTTPMethods, auth: Bool = true,isPut:Bool = false) throws -> URLRequest
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
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
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
            let access_token = cacheUser.storedValue?.authToken ?? "WudmEczwDKEdEDR5SLTN"
//            let access_token = cacheUser.storedValue?.authToken ?? "8F9WIG9MwqcTJkpkRXrP"

            request.setValue(access_token , forHTTPHeaderField: "access_token")

            
            
        }
      
        return request
        
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
            let access_token = cacheUser.storedValue?.authToken ?? "WudmEczwDKEdEDR5SLTN"
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
    
    public static func POST3<T: Decodable>(route: Routes, auth: Bool = true, body: [String: Any]) async throws -> T {
        var request = try makeRequest2(route: route, method: .POST, auth: auth)
        
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
