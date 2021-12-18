//
//  ViewModeType.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/18.
//


import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
