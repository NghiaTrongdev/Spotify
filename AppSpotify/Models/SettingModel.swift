//
//  Settings.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 9/5/24.
//

import Foundation
struct Section {
    let title : String
    let options : [Option]
}
struct Option {
    let title: String
    let handle : () -> Void
}
