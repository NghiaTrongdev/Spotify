//
//  Categories.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 8/6/24.
//

import Foundation
struct CategoriesRespone : Codable {
    let categories : CategoriesPlayList
}
struct CategoriesPlayList : Codable{
    let items : [Category]
}
struct Category : Codable {
    let icons : [APIImage]
    let id : String
    let name : String
}
