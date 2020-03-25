//
//  AnywhereFitnessController.swift
//  anywherefitness
//
//  Created by patelpra on 3/24/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case noUser
    case IncorrectPassword
    case noAuth
    case unauthorized
    case otherError(Error)
    case noData
    case decodeError
    case userNameTaken
}

class AnyWhereFitnessController {
    
    
    var bearer: Bearer?
    
    private let baseURL = URL(string: "https://lambda-anywhere-fitness.herokuapp.com/api")!
    
    func registerUser(with user: RegisterUser, completion: @escaping (Error?) -> Void) {
        let registerUserUrl = baseURL.appendingPathComponent("auth/register")
        
        var request = URLRequest(url: registerUserUrl)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(user)
                request.httpBody = jsonData
            } catch {
                print("Error encoding user object: \(error)")
                completion(error)
                return
            }
            
            URLSession.shared.dataTask(with: request) { (_, response, error) in
                guard error == nil else {
                    completion(error)
                    return
                }
                if let response = response as? HTTPURLResponse,
                    response.statusCode != 200 {
                    completion(NSError(domain: "", code: response.statusCode, userInfo: nil))
                    return
                }
                completion(nil)
            }.resume()
        }
    
    func signIn(with user: User, completion: @escaping (Error?) -> Void) {
        let loginUrl = baseURL.appendingPathComponent("auth/login")
        
        var request = URLRequest(url: loginUrl)
            request.httpMethod = HTTPMethod.post.rawValue
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let jsonEncoder = JSONEncoder()
            do {
                let jsonData = try jsonEncoder.encode(user)
                request.httpBody = jsonData
            } catch {
                print("Error encoding user object: \(error)")
                completion(error)
                return
            }
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard error == nil else {
                    completion(error)
                    return
                }
                
                guard let data = data else {
                    completion(NSError())
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    self.bearer = try decoder.decode(Bearer.self, from: data)
                } catch {
                    print("Error decoding bearer object: \(error)")
                    completion(error)
                    return
                }
                completion(nil)
            }.resume()
        }
    

    
    
    
    
    
    
    
    
    
    
}
