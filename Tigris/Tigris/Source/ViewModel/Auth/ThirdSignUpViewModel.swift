//
//  ThirdSignUpViewModel.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/19.
//

import Foundation
import RxSwift
import RxCocoa

class ThirdSignUpViewModel: ViewModelType {
    private let disposeBag = DisposeBag()
    
    struct Input {
        let name: Driver<String>
        let id: Driver<String>
        let pw: Driver<String>
        let checkPw: Driver<String>
        let doneTap: Driver<Void>
    }
    
    struct Output {
        let checkIdResult: PublishRelay<Bool>
        let isEnable: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let api = Service()
        
        let info = Driver.combineLatest(input.name, input.name, input.pw, input.checkPw)
        let checkIdResult = PublishRelay<Bool>()
        let isEnable = info.map { !$0.0.isEmpty && !$0.1.isEmpty && !$0.2.isEmpty && !$0.3.isEmpty}
        
        input.doneTap.asObservable().withLatestFrom(input.id).flatMap{ id in
            api.checkId(id)
        }.subscribe(onNext: { res in
            print(res)
            switch res {
            case .ok:
                checkIdResult.accept(true)
            default:
                checkIdResult.accept(false)
            }
        }).disposed(by: disposeBag)
        
        return Output(checkIdResult: checkIdResult,
                      isEnable: isEnable.asDriver())
    }
}
