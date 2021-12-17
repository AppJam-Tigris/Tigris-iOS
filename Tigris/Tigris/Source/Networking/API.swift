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
}

extension API: TargetType {
    
    var baseURL: URL {
        URL(string: "")!
    }
    
    var path: String {
        switch self {
        case .signIn:
            return "/auth/login"
        case .signUp:
            return "/auth/signup"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signIn, .signUp:
            return .post
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
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .signUp, .signIn:
            return ["Content-Type" : "application/json"]
        }
    }
}
