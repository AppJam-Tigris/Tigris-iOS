//
//  API.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/17.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

enum API {
    case signIn(_ id: String, _ password: String)
    case signUp(_ id: String, _ password: String)
    case postPhoneNum(_ num: String)
    case checkPhoneNum(_ num: String, _ code: Int)
}

extension API: TargetType {
    
    var baseURL: URL {
        URL(string: "http://49.247.195.161:8080")!
    }
    
    var path: String {
        switch self {
        case .signIn:
            return "/user/auth"
        case .signUp:
            return "/user"
        case .postPhoneNum, .checkPhoneNum:
            return "/user/phone"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signIn, .signUp, .postPhoneNum:
            return .post
        case .checkPhoneNum:
            return .put
        }
    }
    
    var task: Task {
        switch self {
        case .signIn(let id, let password):
            return .requestParameters(parameters: ["uid": id, "password": password],
                                      encoding: JSONEncoding.prettyPrinted)
        case .signUp(let id, let password):
            return .requestParameters(parameters: ["uid": id, "password": password],
                                      encoding: JSONEncoding.prettyPrinted)
        case .postPhoneNum(let num):
            return .requestParameters(parameters: ["phone_number": num], encoding: JSONEncoding.prettyPrinted)
        case .checkPhoneNum(let num, let code):
            return .requestParameters(parameters: ["phone_number": num, "code": code], encoding: JSONEncoding.prettyPrinted)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .signUp, .signIn, .postPhoneNum, .checkPhoneNum:
            return ["Content-Type" : "application/json"]
        }
    }
}
