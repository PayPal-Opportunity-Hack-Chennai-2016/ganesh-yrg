//
//  ServiceManager.swift
//  EcoKitcheniOS
//
//  Created by mh53653 on 11/12/16.
//  Copyright © 2016 madan. All rights reserved.
//

import Foundation


class ServiceManager {
    
    private let BASE_URL = "http://192.168.113.25:80/api/"
    
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
    
    func allLocations(completion:@escaping (_ locations: [Location]) -> Void) {
        // mobile
        // password
        
        let urlString = BASE_URL + "locations"
        
        let url = URL(string: urlString)
        if let url = url {
            var urlRequest = URLRequest(url: url)
            // params
            // content type
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")  // the request is JSON
            urlRequest.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    // JSON Serialization
                    var locations = [Location]()
                    if let data = data {
                        let jsonData = try! JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]]
                        if let jsonData = jsonData {
                            for item in jsonData {
                                let address = item["address"] as? String
                                let description = item["description"] as? String
                                let status = item["status"] as? Bool
                                let latitude = item["lat"] as? String
                                let longitude = item["long"] as? String
                                
                                let location = Location(address: address!, description: description!, status: status!,
                                                        latitude: Double(latitude!)!, longitude: Double(longitude!)!)
                                
                                locations.append(location)
                                
                            }
                           completion(locations)
                        } else {
                            completion(locations)
                        }
                    } else {
                        print("No Data")
                    }
                }
                
            }
            task.resume()
        }
    }
    
    
    func updateLocation(location : Location) {
        // mobile
        // password
        
        let urlString = BASE_URL + "location"
        
        let url = URL(string: urlString)
        if let url = url {
            var urlRequest = URLRequest(url: url)
            // params
            // content type
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")  // the request is JSON
            urlRequest.httpMethod = "POST"
            let params = ["description":location.description,"userId":GLOBAL_USERID,"long":location.longitude, "address":location.address, "lat":location.latitude] as [String : Any];
            
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
                            let locationId = jsonData?["locationId"] as? Int
                            print("userID\(locationId)")
                            // show alert
                        
                        } else {
                            let message = jsonData?["message"] as? String
                            print(message)
                        }
                    } else {
                        print("No Data")
                    }
                }
                
            }
            task.resume()
        }
    }
    
    
    func updateFeedback(feedback : Feedback, completion:@escaping (_ success: Int) -> Void) {
        // mobile
        // password
        
        let urlString = BASE_URL + "feedback"
        
        let url = URL(string: urlString)
        if let url = url {
            var urlRequest = URLRequest(url: url)
            // params
            // content type
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")  // the request is JSON
            urlRequest.httpMethod = "POST"
            let params = ["content":feedback.content,"locationId":feedback.locationId,"userId":feedback.userId,"courtesy":feedback.courtesy, "cleanliness":feedback.cleanliness,"qualityOfFood":feedback.qualityOfFood,"quantityOfFood":feedback.quantityOfFood,"foodTaste":feedback.foodTaste] as [String : Any];
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
                            completion(1)
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
