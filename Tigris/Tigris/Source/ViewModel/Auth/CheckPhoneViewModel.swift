//
//  ThirdSignUpViewModel.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/18.
//

import UIKit
import RxSwift
import RxCocoa

class CheckPhoneViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let name: String
        let phoneNum: Driver<String>
        let code: Driver<String>
        let birth: String
        let gender: String
        let nationality: String
        let location: Location
        let uid: String
        let password: String
        let numBtnTap: Driver<Void>
        let checkNum: Driver<String>
    }
    
    struct Output {
        let postNumResult: PublishRelay<Bool>
        let checkNumResult: PublishRelay<Bool>
        let signupResult: PublishRelay<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let api = Service()
        let info = Driver.combineLatest(input.phoneNum, input.checkNum)
        let info2 = Driver.combineLatest(input.phoneNum, input.code)
        
        let numResult = PublishRelay<Bool>()
        let checkNumResult = PublishRelay<Bool>()
        let signupResult = PublishRelay<Bool>()
        
        input.numBtnTap.asObservable().withLatestFrom(input.phoneNum).flatMap{ number in
            api.postPhoneNum(number)
        }.subscribe(onNext: { res in
            print(res)
            switch res {
            case .ok:
                numResult.accept(true)
            default:
                numResult.accept(false)
            }
        }).disposed(by: disposeBag)
        
        return Output(postNumResult: numResult, checkNumResult: checkNumResult, signupResult: signupResult)
    }
}
