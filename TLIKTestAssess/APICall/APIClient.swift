//
//  APIClient.swift
//  TLIKTestAssess
//
//  Created by ishteyaque on 16/11/18.
//  Copyright © 2018 ishteyaque. All rights reserved.
//
import Foundation

typealias JSON = [String: Any]
typealias JSONSARR = [String]
typealias JSONARR = [Any]

let BASE_IP_ADDRESS_API="https://api.nytimes.com/svc/"
let apiKey="ef848ca1c21741969bb0459ca8542b65"
enum EndPoint: String {
    case mostviewedNews = "mostpopular/v2/mostviewed/all-sections/7.json"
}
//@@*** Catch Service errors
enum ServiceError: Error {
    case noInternetConnection
    case custom(String)
    case other
}

extension ServiceError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "No Internet connection"
        case .other:
            return "Something went wrong"
        case .custom(let message):
            return message
        }
    }
}

extension ServiceError {
    // TODO: add a provision for request time out.
    init(json: JSON) {
        if let message =  json["error_description"] as? String {
            self = .custom(message)
        }
        else if let message = json["message"] as? String {
            self = .custom(message)
        }
        else {
            self = .other
        }
    }
}


//@@@*** Defines HTTP Request types
enum RequestMethod: String {
    case get =      "GET"
    case post =     "POST"
    case put =      "PUT"
    case delete =   "DELETE"
}

//TODO: - Add more constructors here
extension URL {
    init(baseUrl: String, path: String, params: JSON, method: RequestMethod) {
        var components = URLComponents(string: baseUrl)!
        components.path += path
        var queryItems = [URLQueryItem]()
        let baseParams = [
            "api_key": apiKey
        ]
        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }

        components.queryItems=queryItems
        self = components.url!
    }
    
    init(baseUrl: String, path: String, method: RequestMethod) {
        var components = URLComponents(string: baseUrl)!
        components.path += path
        var queryItems = [URLQueryItem]()
        let baseParams = [
            "api_key": apiKey
        ]
        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        components.queryItems = queryItems
        self = components.url!
        
    }
}

extension URLRequest {
    struct HTTPHeader {
        static let accept = "Accept"
        static let contentType = "Content-Type"
        static let authorization = "Authorization"
    }
    
    struct HTTPHeaderVal {
        static let Json = "application/json"
        static let UrlEncoded = "application/x-www-form-urlencode"
    }
}

//TODO: - Add more constructors here
extension URLRequest {
    init(baseUrl: String, path: String, method: RequestMethod, params: JSON) {
        let url = URL(baseUrl: baseUrl, path: path, params: params, method: method)
        self.init(url: url)
        httpMethod = method.rawValue
        setValue(HTTPHeaderVal.Json, forHTTPHeaderField: HTTPHeader.accept)
        setValue(HTTPHeaderVal.Json, forHTTPHeaderField: HTTPHeader.contentType)
        
        switch method {
        case .post, .put:
            httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
        default:
            break
        }
    }
    
    //@@.. Using with Login especially ..@@
    init(baseUrl: String, path: String, method: RequestMethod, params: String) {
        let url = URL(baseUrl: baseUrl, path: path, method: method)
        self.init(url: url)
        httpMethod = method.rawValue
        setValue(HTTPHeaderVal.Json, forHTTPHeaderField: HTTPHeader.accept)
        setValue(HTTPHeaderVal.UrlEncoded, forHTTPHeaderField: HTTPHeader.contentType)
        switch method {
        case .post, .put:
            httpBody = params.data(using: .utf8)
        default:
            break
        }
    }
}

//final
class APIClient {
    
    private var baseUrl: String
    static let sharedClient = APIClient(baseUrl: BASE_IP_ADDRESS_API)
    private init() {self.baseUrl = BASE_IP_ADDRESS_API}
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func load(path: String, method: RequestMethod, params: JSON, completion: @escaping (Any?, ServiceError?) -> ()) -> URLSessionDataTask? {
        // Checking internet connection availability
        if !Reachability.isConnectedToNetwork() {
            completion(nil, ServiceError.noInternetConnection)
            return nil
        }
        
        // Creating the URLRequest object
        let request = URLRequest(baseUrl: baseUrl, path: path, method: method, params: params)
        
        // Sending request to the server.
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Parsing incoming data
            var object: Any? = nil
            if let data = data {
                object = try? JSONSerialization.jsonObject(with: data, options: [])
            }
            
            if let httpResponse = response as? HTTPURLResponse, (200..<300) ~= httpResponse.statusCode {
                completion(object, nil)
            } else {
                let error = (object as? JSON).flatMap(ServiceError.init) ?? ServiceError.other
                completion(nil, error)
            }
        }
        task.resume()
        return task
    }
}
