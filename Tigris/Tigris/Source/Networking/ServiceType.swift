//
//  StatusCode.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/17.
//

import Foundation

enum StatusCode: Int {
    case ok = 200
    case createOk = 201
    case deleteOk = 204
    case wrongRequest = 400
    case tokenError = 401
    case notFound = 404
    case conflict = 409
    case fail = 0
}
