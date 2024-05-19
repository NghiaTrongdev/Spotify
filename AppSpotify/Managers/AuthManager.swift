//
//  AuthManager.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 8/5/24.
//

import Foundation

final class AuthManager {
    private var refreshingToken = false
    static let shared = AuthManager()
    
    private  init(){}
   

    
    public var signInUrl : URL? {
        
        let base = "https://accounts.spotify.com/authorize"
        let string = "\(base)?response_type=code&client_id=\(Constants.clientId)&scope=\(Constants.scope )&redirect_uri=\(Constants.redirectionURL)&show_dialog=TRUE"
        return URL(string: string )
    }
    var isSignedIn : Bool{
        return accessToken != nil
    }
    private var accessToken : String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    private var refreshToken : String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    private var tokenExpiration : Date? {
        return UserDefaults.standard.object(forKey: "expirationDate") as? Date
    }
    private var shouldRefreshToken : Bool {
        guard let expirationDate = tokenExpiration else {
            return false
        }
        let currentDate = Date()
        let fiveminutes : TimeInterval = 300
        
        
        return currentDate.addingTimeInterval(fiveminutes) >= expirationDate
    }
    public func exchangeCodeforToken(code: String,completion : @escaping((Bool)-> Void)){
        // handle
        
        guard let url = URL(string: Constants.tokenURL) else {
            return
        }
        
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "authorization_code"),
            URLQueryItem(name: "redirect_uri", value: "\(Constants.redirectionURL)"),
            URLQueryItem(name: "code", value: code),
        
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = Constants.clientId + ":" + Constants.clientSecret
        let data  = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            completion(false)
            return
        }
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")

        
        let task = URLSession.shared.dataTask(with: request){[weak self] data , _ , error in
            guard let data = data , error == nil else {
                completion(false)
                return
            }
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.caheToken(result : result)
                
            }catch {
                print(error.localizedDescription)
                completion(false)
                
            }
        }
        task.resume()
    }
    
    private var onRefreshBlocks = [((String)-> Void)]()
    public func withValidToken(completion : @escaping(String)->Void){
        
        guard !refreshingToken  else {
            onRefreshBlocks.append(completion)
            return
        }
        if shouldRefreshToken {
            refreshAccessToken {[weak self] success in
                
                    if let token = self?.accessToken , success {
                        completion(token)
                    }
                
                
            }
        } else if let token = accessToken {
            completion(token)
        }
    }
    
    
    
    public func refreshAccessToken(completion : ((Bool) -> Void)?){
        guard  !refreshingToken else {
            return
        }
        guard let refreshToken = self.refreshToken else {
            return
        }
        guard !shouldRefreshToken else {
            completion?(true)
            return
        }
        guard let url = URL(string: Constants.tokenURL) else {
            return
        }
        
        refreshingToken = true
        var components = URLComponents()
        components.queryItems = [
            URLQueryItem(name: "grant_type", value: "refresh_token"),
            URLQueryItem(name: "refresh_token", value: refreshToken)
        ]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
        request.httpBody = components.query?.data(using: .utf8)
        
        let basicToken = Constants.clientId + ":" + Constants.clientSecret
        let data  = basicToken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            completion?(false)
            return
        }
        
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")

        
        let task = URLSession.shared.dataTask(with: request){[weak self] data , _ , error in
            self?.refreshingToken = false
            guard let data = data , error == nil else {
                completion?(false)
                return
            }
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.onRefreshBlocks.forEach{$0(result.access_token)}
                self?.onRefreshBlocks.removeAll()
                self?.caheToken(result : result)
                
            }catch {
                print(error.localizedDescription)
                completion?(false)
                
            }
        }
        task.resume()
        
    }
    private func caheToken(result : AuthResponse){
        UserDefaults.standard.setValue(result.access_token, forKey: "access_token")
        if let refreshToken = result.refresh_token {
            UserDefaults.standard.setValue(refreshToken, forKey: "refresh_token")
        }
       
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expires_in )), forKey: "expirationDate")
        
    }
}
