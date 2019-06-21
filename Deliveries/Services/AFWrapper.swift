//
//  AFWrapper.swift
//  Deliveries
//
//  Created by Pouya Ghasemi on 6/21/19.
//  Copyright © 2019 Deliveries. All rights reserved.
//

import Alamofire
import Foundation

struct ErrorModel: Codable {
    var message: String
    var code: String
}

struct EmptyStruct {
    
}

enum RequestState <T, E> {
    case loading
    case success(T)
    case failure(E)
}

class AFWrapper: NSObject {
    
    class func get(_ url: String, encoding: ParameterEncoding = JSONEncoding.default, headers: [String: String] = getHeader(), success:@escaping (Data) -> Void, failure:@escaping (ErrorModel) -> Void) {
        
        self.request(url, method: .get, params: nil, encoding: encoding, headers: headers, success: { data in
            success(data)
        }) { errorModel in
            failure(errorModel)
        }
    }
    class func post(_ url: String, params: [String: Any]?, encoding: ParameterEncoding = JSONEncoding.default, headers: [String: String] = getHeader(), success:@escaping (Data) -> Void, failure:@escaping (ErrorModel) -> Void) {
        
        self.request(url, method: .post, params: params, encoding: encoding, headers: headers, success: { data in
            success(data)
        }) { errorModel in
            failure(errorModel)
        }
    }
    class func put(_ url: String, params: [String: Any]?, encoding: ParameterEncoding = JSONEncoding.default, headers: [String: String] = getHeader(), success:@escaping (Data) -> Void, failure:@escaping (ErrorModel) -> Void) {
        
        self.request(url, method: .put, params: params, encoding: encoding, headers: headers, success: { data in
            success(data)
        }) { errorModel in
            failure(errorModel)
        }
    }
    class func delete(_ url: String, params: [String: Any]?, encoding: ParameterEncoding = JSONEncoding.default, headers: [String: String] = getHeader(), success:@escaping (Data) -> Void, failure:@escaping (ErrorModel) -> Void) {
        
        self.request(url, method: .delete, params: params, encoding: encoding, headers: headers, success: { data in
            success(data)
        }) { errorModel in
            failure(errorModel)
        }
    }
    class func upload(_ url: String, file: Data, headers: [String: String] = getHeader(), success:@escaping (Data) -> Void, failure:@escaping (ErrorModel) -> Void) {
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(file, withName: "files", fileName: "\(UUID().uuidString).jpeg", mimeType: "image/jpeg")
            },
            to: url,
            method: .post,
            headers: headers,
            encodingCompletion: { encodingResult in
                
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseData { data in
                        #if DEBUG
                        self.logHttpError(data: data, params: nil)
                        #endif
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                        if data.response?.statusCode == 200 {
                            if let data = data.data {
                                success(data)
                            }
                        } else {
                            if let serverData = data.data {
                                if let decodedData = try? JSONDecoder().decode(ErrorModel.self, from: serverData) {
                                    failure(decodedData)
                                    return
                                }
                            }
                            if let networkError = data.result.error {
                                failure(ErrorModel(message: networkError.localizedDescription, code: "0"))
                            }
                            failure(ErrorModel(message: "Upload Error", code: String(data.response?.statusCode ?? 0)))
                        }
                    }
                case .failure(let encodingError):
                    failure(ErrorModel(message: encodingError.localizedDescription, code: "0"))
                }
            }
        )
        
    }
    class func customRequest(_ url: String, method: HTTPMethod, params: Any, headers: [String: String] = getHeader(), success:@escaping (Data) -> Void, failure:@escaping (ErrorModel) -> Void) {
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = method.rawValue
        for head in headers {
            request.setValue(head.value, forHTTPHeaderField: head.key)
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if JSONSerialization.isValidJSONObject(params) {
            request.httpBody = try? JSONSerialization.data(withJSONObject: params)
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        Alamofire.request(request).validate(statusCode: 200 ... 300).responseData { data in
            #if DEBUG
            logHttpError(data: data, params: params)
            #endif
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            data.result.ifSuccess {
                if let data = data.data {
                    success(data)
                }
            }
            data.result.ifFailure {
                if let serverData = data.data {
                    if let decodedData = try? JSONDecoder().decode(ErrorModel.self, from: serverData) {
                        failure(decodedData)
                        return
                    }
                }
                if let networkError = data.result.error {
                    failure(ErrorModel(message: networkError.localizedDescription, code: "0"))
                }
            }
        }
    }
    class func request(_ url: String, method: HTTPMethod, params: [String: Any]?, encoding: ParameterEncoding, headers: [String: String]?, success:@escaping (Data) -> Void, failure:@escaping (ErrorModel) -> Void) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        Alamofire.request(url, method: method, parameters: params, encoding: encoding, headers: headers).validate(statusCode: 200 ... 300).responseData { data in
            #if DEBUG
            logHttpError(data: data, params: params)
            #endif
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            data.result.ifSuccess {
                if let data = data.data {
                    success(data)
                }
            }
            data.result.ifFailure {
                if let serverData = data.data {
                    if let decodedData = try? JSONDecoder().decode(ErrorModel.self, from: serverData) {
                        failure(decodedData)
                        return
                    }
                }
                if let networkError = data.result.error {
                    failure(ErrorModel(message: networkError.localizedDescription, code: "0"))
                }
            }
        }
    }
    private static func logHttpError(data: DataResponse<Data>, params: Any?) {
        print("\n****** API CALL (\(data.request?.httpMethod ?? "GET") - \(data.response?.statusCode ?? 0) - \(Date().timeIntervalSince1970)) ******\n", data.request?.url?.absoluteString ?? "URL", "\n")
        print("Header: \(data.request?.allHTTPHeaderFields ?? ["header": "nil"])\n")
        if params != nil {
            print("Params :\n\n", params!, "\n")
        }
        if let json = try? JSONSerialization.jsonObject(with: data.data!, options: JSONSerialization.ReadingOptions.allowFragments) {
            print("Response :\n", json)
        }
        print("\n*~*~*~*~*~*~*~*~*~*~~*~**~*~*~*~*~*~*\n")
        
        if data.response?.statusCode == 401 || data.response?.statusCode == 403 {
            print("-------INVALIDE TOKEN-------")
        }
        print("----------------")
    }
    
}
