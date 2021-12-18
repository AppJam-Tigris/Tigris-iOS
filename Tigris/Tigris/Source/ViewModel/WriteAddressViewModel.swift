//
//  WriteAddressViewModel.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/19.
//

import Foundation
import RxSwift
import RxCocoa

class WriteAddressViewModel: ViewModelType {
    private let disposeBag = DisposeBag()
    struct Input {
        let keyWord: Driver<String>
        let tap: Driver<Void>
    }
    
    struct Output {
        let posts: BehaviorRelay<[postModel]>
        let result: PublishRelay<Bool>
        
    }
    
    func transform(_ input: Input) -> Output {
        let api = Service()
        let posts = BehaviorRelay<[postModel]>(value: [])
        let result = PublishRelay<Bool>()
        
        
        input.tap.asObservable().withLatestFrom(input.keyWord).flatMap{ keyword in
            api.search(keyword)
        }.subscribe(onNext: { data, res in
            switch res {
            case .ok:
                posts.accept(data!.posts)
                result.accept(true)
            default:
                result.accept(false)
            }
        }).disposed(by: disposeBag)
        
        return Output(posts: posts, result: result)
    }
}
