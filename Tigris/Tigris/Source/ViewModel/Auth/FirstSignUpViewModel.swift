//
//  FirstViewModel.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/19.
//

import Foundation
import RxSwift
import RxCocoa

class FirstSignUpViewModel: ViewModelType {
    private let disposeBag = DisposeBag()
    
    struct Input {
        let birth: Driver<String>
        let gender: Driver<String>
        let nationality: Driver<String>
    }
    
    struct Output {
        let isEnable: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let info = Driver.combineLatest(input.birth, input.gender, input.nationality)
        let isEnable = info.map { !$0.0.isEmpty && !$0.1.isEmpty && !$0.2.isEmpty}
        
        return Output(isEnable: isEnable.asDriver())
    }
    
    
}
