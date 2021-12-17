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
    
    func signUp(_ id: String, _ password: String) -> Single<StatusCode> {
        return provider.rx.request(.signUp(id, password))
            .filterSuccessfulStatusCodes()
            .map{ _ -> StatusCode in return .createOk }
            .catch{ [unowned self] in return .just(setNetworkError($0))}
    }
    
    func setNetworkError(_ error: Error) -> StatusCode {
        print(error)
        print(error.localizedDescription)
        guard let status = (error as? MoyaError)?.response?.statusCode else { return (.fail) }
        return (StatusCode(rawValue: status) ?? .fail)
    }
    
}

