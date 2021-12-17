//
//  TokenModel.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/17.
//

import Foundation

struct TokenModel: Codable {
    let access_token: String
    let refresh_token: String
}

enum Token {
    
    static var _access_token: String?
    static var access_token: String? {
        get {
            _access_token = UserDefaults.standard.string(forKey: "token")
            return _access_token
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "token")
            _access_token = UserDefaults.standard.string(forKey: "token")
        }
    }
    
    static var _refresh_token: String?
    static var refresh_token: String? {
        get {
            _refresh_token = UserDefaults.standard.string(forKey: "refreshToken")
            return _refresh_token
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "refreshToken")
            _refresh_token = UserDefaults.standard.string(forKey: "refreshToken")
        }
    }

    static func logOut() {
        access_token = nil
        refresh_token = nil
    }
}
