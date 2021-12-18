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
    case signUp(_ name: String, _ phone_number: String, _ code: String, _ birth_day: String,
                _ gender: String, _ nationality: String, _ location: Location, _ uid: String, _ pasword: String)
    case postPhoneNum(_ num: String)
    case checkPhoneNum(_ num: String, _ code: String)
    case checkId(_ id: String)
    case search(_ keywords: String)
}

extension API: TargetType {
    
    var baseURL: URL {
        URL(string: "http://13.209.176.77:8080")!
    }
    
    var path: String {
        switch self {
        case .signIn:
            return "/user/auth"
        case .signUp:
            return "/user"
        case .postPhoneNum, .checkPhoneNum:
            return "/user/phone"
        case .checkId:
            return "/user/duplicate"
        case .search:
            return "/clinic/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signIn, .signUp, .postPhoneNum, .checkId:
            return .post
        case .checkPhoneNum:
            return .put
        case .search:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .signIn(let id, let password):
            return .requestParameters(parameters: ["uid": id, "password": password],
                                      encoding: JSONEncoding.prettyPrinted)
        case .signUp(let name, let phoneNum, let code, let birth, let gender, let nationality, let location, let uid, let password):
            return .requestParameters(parameters: ["name": name, "phone_number": phoneNum, "code": code, "birth_day": birth, "gender": gender, "nationality": nationality, "location": location,
                                                   "uid": uid, "password": password],
                                      encoding: JSONEncoding.prettyPrinted)
        case .postPhoneNum(let num):
            return .requestParameters(parameters: ["phone_number": num], encoding: JSONEncoding.prettyPrinted)
        case .checkPhoneNum(let num, let code):
            return .requestParameters(parameters: ["phone_number": num, "code": code], encoding: JSONEncoding.prettyPrinted)
        case .checkId(let id):
            return .requestParameters(parameters: ["uid": id], encoding: JSONEncoding.prettyPrinted)
        case .search(let keyword):
            return .requestParameters(parameters: ["keyword": keyword], encoding: JSONEncoding.prettyPrinted)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .signUp, .signIn, .postPhoneNum, .checkPhoneNum, .checkId:
            return ["Content-Type" : "application/json"]
        default:
            guard let token = Token.access_token else {return ["Content-Type" : "application/json"]}
            return ["Authorization" : "Bearer" + token]
        }
    }
}
