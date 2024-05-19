//
//  Artist.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 8/5/24.
//

import Foundation
struct Artist : Codable {
    let external_urls : [String : String]
    let id : String
    let name : String
    let type : String
    
}
