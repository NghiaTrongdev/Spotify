//
//  getSomeArtistRespone.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 10/6/24.
//

import Foundation
struct getSomeArtistResponse : Codable {
    let artists : [ArtistResponse]
}
struct ArtistResponse : Codable {
    let id : String
    let images : [APIImage]
    let name : String
    
}
