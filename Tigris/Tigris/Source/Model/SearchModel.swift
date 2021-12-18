//
//  SearchModel.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/19.
//

import Foundation

struct postModel: Codable {
    let name: String
    let address: String
    let ciry: String
    let manager_phone_number: String
}

struct posts: Codable {
    var posts: [postModel]
}
