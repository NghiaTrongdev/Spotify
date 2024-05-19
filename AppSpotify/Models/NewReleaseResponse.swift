//
//  APINewReleaseResponse.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 10/5/24.
//

import Foundation

struct NewReleaseResponse : Codable {
    let albums : AlbumResponse
    let next : String?
    let previous : String?
}

struct AlbumResponse : Codable {
    let items : [Album]
}
struct Album : Codable{
    let album_type : String
    let total_tracks : Int
    let available_markets : [String]
//    let external_urls : [String : String]
    let id : String
    let images : [APIImage]
    let name : String
    let release_date : String
//    let release_date_precision : String
//    let type : String
    let artists : [Artist]
    
   
}

