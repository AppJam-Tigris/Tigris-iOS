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
        let signupTap: Driver<Void>
        let numBtnTap: Driver<Void>
        let checkNum: Driver<String>
        let checkBtnTap: Driver<Void>
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
        
        input.checkBtnTap.asObservable().withLatestFrom(info).flatMap{ num, code in
            api.checkPhoneNum(num, code)
        }.subscribe(onNext: {  res in
            switch res {
            case .ok:
                checkNumResult.accept(true)
            default:
                checkNumResult.accept(false)
            }
        }).disposed(by: disposeBag)
        
        input.signupTap.asObservable().withLatestFrom(info2).flatMap{ phone, Code in
            api.signUp(input.name, phone, Code, input.birth, input.gender, input.nationality, input.location, input.uid, input.password)
        }.subscribe(onNext: { res in
            switch res {
            case .createOk:
                signupResult.accept(true)
            default:
                signupResult.accept(false)
            }
        }).disposed(by: disposeBag)
        
        return Output(postNumResult: numResult, checkNumResult: checkNumResult, signupResult: signupResult)
    }
}
