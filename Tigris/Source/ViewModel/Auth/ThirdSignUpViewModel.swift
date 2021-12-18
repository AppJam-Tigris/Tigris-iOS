//
//  ThirdSignUpViewModel.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/18.
//

import UIKit
import RxCocoa

class ThirdSignUpViewModel: ViewModelType {
    
    struct Input {
        let phoneNum: Driver<String>
        let numBtnTap: Driver<Void>
        let checkNum: Driver<Int>
        let checkBtnTap: Driver<Void>
    }
    
    struct Output {
        let result: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let api = Service()
        let info = Driver.combineLatest(input.phoneNum, input.checkNum)
        let result = PublishRelay<Bool>()
        
    }
}
