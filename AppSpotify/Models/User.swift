//
//  User.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 28/5/24.
//

import Foundation
struct User : Codable {
    let id : String
    let external_urls : [String : String]
    let display_name : String
    let href : String
}
