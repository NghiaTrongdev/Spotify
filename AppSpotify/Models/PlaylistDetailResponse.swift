//
//  PlaylistDetailResponse.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 11/5/24.
//

import Foundation
struct PlaylistDetailResponse : Codable {
    let description : String?
    let external_urls : [String : String]
    let id : String
    let images: [APIImage]?
    let name : String
    let tracks : Track
}
struct Track : Codable {
    let items : [PlayListTrackObject]
}
struct PlayListTrackObject : Codable {
    let track : TrackObject
}
struct TrackObject : Codable{
    let album : Album
    let artists : [Artist]
    let id : String
    let name : String
    let duration_ms : Int
    let uri : String
}

