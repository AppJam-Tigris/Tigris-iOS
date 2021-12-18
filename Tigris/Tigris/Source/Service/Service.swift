//
//  Service.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/17.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

final class Service {
    
    let provider = MoyaProvider<API>()
    
    func signIn(_ id: String, _ password: String) -> Single<StatusCode> {
        return provider.rx.request(.signIn(id, password))
            .filterSuccessfulStatusCodes()
            .map(TokenModel.self)
            .map{ response -> StatusCode in
                Token.access_token = response.access_token
                Token.refresh_token = response.refresh_token
                return .ok
            }
            .catch { [unowned self] in return .just(setNetworkError($0))}
    }
    
    func signUp(_ name: String, _ phone_num: String, _ code: String, _ birthday: String, _ gender: String, _ nationlity: String, _ location: Location, _ uid: String, _ password: String) -> Single<StatusCode> {
        return provider.rx.request(.signUp(name, phone_num, code, birthday, gender, nationlity, location, uid, password))
            .filterSuccessfulStatusCodes()
            .map{ _ -> StatusCode in return .createOk }
            .catch{ [unowned self] in return .just(setNetworkError($0))}
    }
    
    func postPhoneNum(_ num: String) -> Single<StatusCode> {
        return provider.rx.request(.postPhoneNum(num))
            .filterSuccessfulStatusCodes()
            .map{_ -> StatusCode in return .ok}
            .catch{ [unowned self] in return .just(setNetworkError($0))}
    }
    
    func checkPhoneNum(_ num: String, _ code: String) -> Single<StatusCode> {
        return provider.rx.request(.checkPhoneNum(num, code))
            .filterSuccessfulStatusCodes()
            .map{_ -> StatusCode in return .ok}
            .catch{ [unowned self] in return .just(setNetworkError($0))}
    }
    
    func checkId(_ id: String) -> Single<StatusCode> {
        return provider.rx.request(.checkId(id))
            .filterSuccessfulStatusCodes()
            .map{_ -> StatusCode in return .ok}
            .catch{ [unowned self] in return .just(setNetworkError($0))}
    }
    
    func search(_ keyword: String) -> Single<(posts?, StatusCode)> {
        return provider.rx.request(.search(keyword))
            .filterSuccessfulStatusCodes()
            .map(posts.self)
            .map{return ($0, .ok)}
            .catch { error in
                print(error)
                return .just((nil, .fail))
            }
    }
    
    func setNetworkError(_ error: Error) -> StatusCode {
        print(error)
        print(error.localizedDescription)
        guard let status = (error as? MoyaError)?.response?.statusCode else { return (.fail) }
        return (StatusCode(rawValue: status) ?? .fail)
    }
    
}

