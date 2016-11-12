//
//  ServiceManager.swift
//  EcoKitcheniOS
//
//  Created by mh53653 on 11/12/16.
//  Copyright © 2016 madan. All rights reserved.
//

import Foundation


class ServiceManager {
    
    private let BASE_URL = "http://192.168.115.1:8080/api/"
    
    func signIn(mobile: String, password: String, completion:@escaping (_ userId: Int) -> Void) {
        // mobile
        // password
        
        let urlString = BASE_URL + "signin"
        
        let url = URL(string: urlString)
        if let url = url {
            var urlRequest = URLRequest(url: url)
            // params
            // content type
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")  // the request is JSON
            urlRequest.httpMethod = "POST"
            let params = ["mobile":mobile, "password":password]
            let data = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            urlRequest.httpBody = data;//paramString.data(using: String.Encoding.utf8)
            
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    // JSON Serialization
                    if let data = data {
                        
                        let jsonData = try! JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                        let success = jsonData?["success"] as! Bool
                        if success {
                            let userId = jsonData?["userId"] as? Int
                            completion(userId!)
                        }
                    } else {
                        print("No Data")
                    }
                }
                
            }
            task.resume()
        }
    }
    
    func signUp(register : RegistrationModel, completion:@escaping (_ userId: Int) -> Void) {
        // mobile
        // password
        
        let urlString = BASE_URL + "signup"
        
        let url = URL(string: urlString)
        if let url = url {
            var urlRequest = URLRequest(url: url)
            // params
            // content type
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")  // the request is JSON
            urlRequest.httpMethod = "POST"
            let params = ["mobile":register.mobileNumber!, "password":register.password!, "name":register.name!, "address":register.address!, "email":register.email!];
            let data = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            urlRequest.httpBody = data;//paramString.data(using: String.Encoding.utf8)
            
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    // JSON Serialization
                    if let data = data {
                        
                        let jsonData = try! JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                        let success = jsonData?["success"] as! Bool
                        if success {
                            let userId = jsonData?["userId"] as? Int
                            print("userID\(userId)")
                            completion(userId!)
                        } else {
                           completion(-1)
                        }
                    } else {
                        print("No Data")
                    }
                }
                
            }
            task.resume()
        }
    }
    
}
