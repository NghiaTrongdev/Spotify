//
//  RecentlyPlayedModel.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 15/5/24.
//

import Foundation
struct RecentlyPlayedModel : Codable {
    let items : [playHistory]
}
struct playHistory : Codable {
    let track : AudioTrack
}
