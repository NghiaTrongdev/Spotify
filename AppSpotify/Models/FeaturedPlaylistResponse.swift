//
//  FeaturedPlaylistResponse.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 10/5/24.
//

import Foundation
struct FeaturedPlaylistResponse : Codable {
    let playlists : PlaylistResponse
    let message : String
}


struct PlaylistResponse : Codable {
    let items : [PlayList]
    
}

struct User : Codable {
    let id : String
    let external_urls : [String : String]
    let display_name : String
    let href : String
}