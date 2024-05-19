//
//  PlaylistDetailResponse.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 11/5/24.
//

import Foundation
struct PlaylistDetailResponse {
    let description : String?
    let external_urls : [String : String]
    let id : String
    let images: [APIImage]
    let name : String
    let tracks : PlaylistResponse
  
  
  
}
