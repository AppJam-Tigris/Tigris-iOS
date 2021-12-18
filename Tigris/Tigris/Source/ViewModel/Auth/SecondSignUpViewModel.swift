//
//  SecondViewModel.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/19.
//

import Foundation
import RxSwift
import RxCocoa

class SecondViewModel: ViewModelType {
    private let disposeBag = DisposeBag()
    
    struct Input {
        let address: Driver<String>
        let road_name: Driver<String>
        let detailAddress: Driver<String>
    }
    
    struct Output {
        let isEnable: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let info = Driver.combineLatest(input.address, input.road_name, input.detailAddress)
        let isEnable = info.map { !$0.0.isEmpty && !$0.1.isEmpty && !$0.2.isEmpty}
        
        return Output(isEnable: isEnable)
    }
}
