//
//  SignInViewModel.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/18.
//

import Foundation
import RxSwift
import RxCocoa

class SignInViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let id: Driver<String>
        let pw: Driver<String>
        let doneTap: Driver<Void>
    }
    
    struct Output {
        let result: PublishRelay<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let api = Service()
        let result = PublishRelay<Bool>()
        let info = Driver.combineLatest(input.id, input.pw)
        
        input.doneTap.asObservable().withLatestFrom(info).flatMap{ id, pw in
            api.signIn(id, pw)
        }.subscribe(onNext: { res in
            print(res)
            switch res {
            case .ok:
                result.accept(true)
            default:
                result.accept(false)
            }

        }).disposed(by: disposeBag)
        
        return Output(result: result)
    }
}
