//
//  SignInViewController.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/18.
//

import UIKit

class SignInViewController: BaseViewController {
    
    private let viewModel = SignInViewModel()
    
    private let logo = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = .init(named: "logoImg")
    }
    
    private let label = UILabel().then {
        $0.text = "편한 코로나 선별진료"
        $0.font = .init(name: Font.medium.rawValue, size: 14)
        $0.textColor = MainColor.darkBlue
    }
    
    private let idView = AuthView().then {
        $0.txt.placeholder = "Email or Phone Number"
        $0.eyesBtn.isHidden = true
    }
    
    private let pwView = AuthView().then {
        $0.txt.placeholder = "PASSWORD"
    }
    
    private let loginBtn = UIButton(type: .system).then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = MainColor.dark
        $0.titleLabel?.font = .init(name: Font.regular.rawValue, size: 16)
        $0.layer.cornerRadius = 15
    }
    
    private let signupBtn = UIButton(type: .system).then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(. white, for: .normal)
        $0.backgroundColor = MainColor.darkBlue
        $0.titleLabel?.font = .init(name: Font.regular.rawValue, size: 16)
        $0.layer.cornerRadius = 15
    }
    
    override func bindViewModel() {
        let input = SignInViewModel.Input(
            id: idView.txt.rx.text.orEmpty.asDriver(),
            pw: pwView.txt.rx.text.orEmpty.asDriver(),
            doneTap: loginBtn.rx.tap.asDriver())
        
        let output = viewModel.transform(input)
        
        output.result.asObservable().subscribe(onNext: { success in
            if success {
                let vc = MainViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                return
            }
            
        }).disposed(by: disposeBag)
    }
    
    override func setNavigation() {
        self.navigationItem.title = "로그인"
    }
    
    override func configureUI() {
        [logo, label, idView, pwView, loginBtn, signupBtn]
            .forEach{view.addSubview($0)}
    }
    
    override func setUpConstraints() {
        
        idView.authView.layer.addBorder([.bottom], color: .gray, width: 1)
        pwView.authView.layer.addBorder([.bottom], color: .gray, width: 1)
        
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
        
        idView.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(30)
        }
        
        pwView.snp.makeConstraints {
            $0.top.equalTo(idView.snp.bottom).offset(41.5)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(30)
        }
        
        loginBtn.snp.makeConstraints {
            $0.top.equalTo(pwView.snp.bottom).offset(95)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(40)
        }
        
        signupBtn.snp.makeConstraints {
            $0.top.equalTo(loginBtn.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(40)
        }
        
    }
    
}
