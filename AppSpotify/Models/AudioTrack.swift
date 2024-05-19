//
//  AudioTrack.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 8/5/24.
//

import Foundation

struct AudioTrack : Codable{
    let album : Album
    let artists : [Artist]
    let available_markets : [String]
    let disc_number : Int
    let duration_ms : Int
    let explicit : Bool 
    let external_urls : [String : String]
    let id : String
    let name : String
    let popularity : Int
    let track_number : Int
}
