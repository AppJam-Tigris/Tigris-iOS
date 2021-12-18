//
//  ThirdSignUpViewController.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/18.
//

import UIKit

class ThirdSignUpViewController: BaseViewController {
    
    private let logo = UIImageView().then {
        $0.image = .init(named: "logoImg")
        $0.contentMode = .scaleAspectFit
    }
    
    private let label = UILabel().then {
        $0.text = "편한 코로나 선별진료"
        $0.textColor = MainColor.darkBlue
        $0.font = .init(name: Font.medium.rawValue, size: 14)
    }
    
    private let phoneNum = AuthView().then {
        $0.txt.placeholder = "Phone Number(핸드폰 번호)"
        $0.eyesBtn.isHidden = true
    }
    
    private let certifiedBtn = UIButton(type: .system).then {
        $0.setTitle("인증 하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.borderWidth = 0.5
        $0.layer.cornerRadius = 5
        $0.titleLabel?.font = .init(name: Font.regular.rawValue, size: 8)
    }
    
    private let authNum = AuthView().then {
        $0.txt.placeholder = "인증 번호"
        $0.eyesBtn.isHidden = true
    }
    
    private let authNumBtn = UIButton(type: .system).then {
        $0.setTitle("인증 확인", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.borderWidth = 0.5
        $0.layer.cornerRadius = 5
        $0.titleLabel?.font = .init(name: Font.regular.rawValue, size: 8)
    }
    
    private let nextBtn = UIButton(type: .system).then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .init(name: Font.medium.rawValue, size: 16)
        $0.layer.cornerRadius = 15
    }
    
    override func setNavigation() {
        self.navigationItem.title = "회원가입"
    }
    
    override func configureUI() {
        [logo, label, phoneNum, certifiedBtn, authNum, authNumBtn, nextBtn]
            .forEach{view.addSubview($0)}
    }
    
    override func setUpConstraints() {
        logo.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(logo.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
        }
        
        phoneNum.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(120)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(38)
        }
        
        certifiedBtn.snp.makeConstraints {
            $0.centerY.equalTo(phoneNum)
            $0.trailing.equalTo(phoneNum.snp.trailing).inset(5)
            $0.height.equalTo(12)
        }
        
        authNum.snp.makeConstraints {
            $0.top.equalTo(phoneNum.snp.bottom).offset(38)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(38)
        }
        
        authNumBtn.snp.makeConstraints {
            $0.centerY.equalTo(authNum)
            $0.trailing.equalTo(authNum.snp.trailing).inset(5)
            $0.height.equalTo(38)
        }
        
        nextBtn.snp.makeConstraints {
            $0.top.equalTo(authNumBtn.snp.bottom).offset(128)
            $0.leading.trailing.equalTo(44)
            $0.height.equalTo(38)
        }
    }
}
