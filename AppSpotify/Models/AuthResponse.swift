//
//  AuthResponse.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 8/5/24.
//

import Foundation
struct AuthResponse : Decodable {
    let access_token : String
    let expires_in : Int
    let refresh_token : String?
    let scope : String
    let token_type : String
}
