//
//  SignUpViewController.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/18.
//

import UIKit

class FirstSignUpViewController: BaseViewController {
    
    private let logo = UIImageView().then {
        $0.image = .init(named: "logoImg")
        $0.contentMode = .scaleAspectFit
    }
    
    private let label = UILabel().then {
        $0.text = "편한 코로나 선별진료소"
        $0.font = .init(name: Font.medium.rawValue, size: 14)
    }
    
    private let name = AuthView().then {
        $0.txt.placeholder = "Name(이름)"
        $0.txt.font = .init(name: Font.regular.rawValue, size: 12)
        $0.eyesBtn.isHidden = true
    }
    
    private let id = AuthView().then {
        $0.txt.placeholder = "ID(아이디)"
        $0.txt.font = .init(name: Font.regular.rawValue, size: 12)
        $0.eyesBtn.isHidden = true
    }
    
    private let idCheckBtn = UIButton(type: .system).then {
        $0.setTitle("중복 확인", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .init(name: Font.regular.rawValue, size: 8)
        $0.layer.borderWidth = 0.5
        $0.backgroundColor = .white
    }
    
    private let pw = AuthView().then {
        $0.txt.placeholder = "PASSWORD(비밀번호)"
        $0.txt.font = .init(name: Font.regular.rawValue, size: 12)
    }
    
    private let checkPw = AuthView().then {
        $0.txt.placeholder = "PASSWORD CHECK(비밀번호 확인)"
        $0.txt.font = .init(name: Font.regular.rawValue, size: 12)
    }
    
    private let nextBtn = UIButton(type: .system).then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = MainColor.darkBlue
        $0.layer.cornerRadius = 15
        $0.titleLabel?.font = .init(name: Font.medium.rawValue, size: 16)
    }
    
    override func setNavigation() {
        self.navigationItem.title = "회원가입"
    }
    
    override func configureUI() {
        [logo, label, name, id, idCheckBtn, pw, checkPw, nextBtn].forEach{view.addSubview($0)}
    }
    
    override func setUpConstraints() {
        idCheckBtn.layer.cornerRadius = 5
        
        [name, id, pw, checkPw].forEach{
            $0.layer.addBorder([.bottom], color: .gray, width: 1)
        }
        
        logo.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(116)
            $0.height.equalTo(38)
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(logo.snp.bottom).offset(18)
            $0.centerX.equalToSuperview()
        }
        
        name.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(61)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(30)
        }
        
        id.snp.makeConstraints {
            $0.top.equalTo(name.snp.bottom).offset(38)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(30)
        }
        
        idCheckBtn.snp.makeConstraints {
            $0.centerY.equalTo(id)
            $0.trailing.equalTo(id.snp.trailing).inset(5)
            $0.width.equalTo(48)
            $0.height.equalTo(12)
        }
        
        pw.snp.makeConstraints {
            $0.top.equalTo(id.snp.bottom).offset(38)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(30)
        }
        
        checkPw.snp.makeConstraints {
            $0.top.equalTo(pw.snp.bottom).offset(38)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(30)
        }
        
        nextBtn.snp.makeConstraints {
            $0.top.equalTo(checkPw.snp.bottom).offset(78)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(40)
        }
    }
}
