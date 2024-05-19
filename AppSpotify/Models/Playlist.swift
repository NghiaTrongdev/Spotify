//
//  Playlist.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 8/5/24.
//

import Foundation
struct PlayList : Codable {
    let collaborative : Bool
    let description : String
    let external_urls : [String : String]
    let id : String
    let images : [APIImage]
    let name : String
    let owner : User
//    let tracks : [String ]
    
}
