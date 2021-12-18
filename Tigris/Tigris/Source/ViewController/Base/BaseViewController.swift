//
//  ViewController.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/17.
//

import UIKit

import RxSwift
import RxCocoa
import SnapKit
import Then

class BaseViewController: UIViewController {
    
    var disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }

    override func viewDidLoad() {
        self.view.backgroundColor = .white
        self.configureUI()
        self.bindViewModel()
        self.setNavigation()
        self.setBtn()
    }
    
    override func viewDidLayoutSubviews() {
        self.setUpConstraints()
    }
    
    func configureUI() {
        
    }

    func setUpConstraints() {
        
    }
    
    func bindViewModel() {
        
    }
    
    func setNavigation() {
    }
    
    func setBtn() {
        
    }

}

