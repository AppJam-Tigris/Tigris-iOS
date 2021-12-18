//
//  ThirdSignUpViewController.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/18.
//

import UIKit

struct Location {
    var address: String?
    var road_name: String?
    var details_address: String?
}

class CheckPhoneViewController: BaseViewController {
    
    private let viewModel = CheckPhoneViewModel()
    
    var birth = String()
    var gender = String()
    var nationality = String()
    var name = String()
    var id = String()
    var pw = String()
    var location = Location(address: nil, road_name: nil, details_address: nil)
    
    private let logo = UIImageView().then {
        $0.image = .init(named: "logoImg")
        $0.contentMode = .scaleAspectFit
    }
    
    private let phoneNum = AuthView().then {
        $0.txt.placeholder = "Phone Number(핸드폰 번호)"
        $0.eyesBtn.isHidden = true
    }
    
    private let errorLabel1 = UILabel().then {
        $0.textColor = .red
        $0.font = .init(name: Font.regular.rawValue, size: 8)
    }
    
    private let certifiedBtn = UIButton(type: .system).then {
        $0.setTitle("인증 하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.borderWidth = 0.5
        $0.layer.cornerRadius = 5
        $0.titleLabel?.font = .systemFont(ofSize: 8)
    }
    
    private let authNum = AuthView().then {
        $0.txt.placeholder = "인증 번호"
        $0.eyesBtn.isHidden = true
    }
    private let errorLabel2 = UILabel().then {
        $0.textColor = .red
        $0.font = .systemFont(ofSize: 8)
    }
    
    private let nextBtn = UIButton(type: .system).then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .init(name: Font.medium.rawValue, size: 16)
        $0.backgroundColor = MainColor.darkBlue
        $0.layer.cornerRadius = 15
    }
    
    override func setNavigation() {
        self.navigationItem.title = "회원가입"
    }
    
    override func configureUI() {
        [logo, phoneNum, certifiedBtn, errorLabel1, authNum, errorLabel2, nextBtn]
            .forEach{view.addSubview($0)}
    }
    
    override func setBtn() {
        nextBtn.rx.tap.subscribe(onNext: { _ in
        let alert = UIAlertController.init(title: "축하합니다.", message: "회원가입에 성공하셨습니다.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: {Action in
            let vc = SignInViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        })
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
    
    override func bindViewModel() {
        let input = CheckPhoneViewModel.Input(name: name,
                                              phoneNum: phoneNum.txt.rx.text.orEmpty.asDriver(),
                                              code: authNum.txt.rx.text.orEmpty.asDriver(),
                                              birth: birth, gender: gender , nationality: nationality,
                                              location: location,
                                              uid: id, password: pw,
                                              numBtnTap: certifiedBtn.rx.tap.asDriver(),
                                              checkNum: authNum.txt.rx.text.orEmpty.asDriver())
        
        let output = viewModel.transform(input)
        
        output.postNumResult.asObservable().subscribe(onNext: {[unowned self] success in
            if success {
                errorLabel1.text = ""
            } else {
                errorLabel1.text = "전화번호 형식이 알맞지 않습니다."
            }
        }).disposed(by: disposeBag)
    }
    
    override func setUpConstraints() {
        [phoneNum, authNum].forEach{$0.layer.addBorder([.bottom], color: .gray, width: 1)}
        logo.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(123)
            $0.height.equalTo(74)
        }
        
        phoneNum.snp.makeConstraints {
            $0.top.equalTo(logo.snp.bottom).offset(120)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(38)
        }
        
        certifiedBtn.snp.makeConstraints {
            $0.centerY.equalTo(phoneNum)
            $0.trailing.equalTo(phoneNum.snp.trailing).inset(5)
            $0.height.equalTo(12)
            $0.width.equalTo(48)
        }
        
        errorLabel1.snp.makeConstraints {
            $0.top.equalTo(phoneNum.snp.bottom).offset(3)
            $0.leading.equalTo(phoneNum.snp.leading)
        }
        
        authNum.snp.makeConstraints {
            $0.top.equalTo(phoneNum.snp.bottom).offset(38)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(38)
        }
        
        errorLabel2.snp.makeConstraints {
            $0.top.equalTo(authNum.snp.bottom).offset(3)
            $0.leading.equalTo(authNum.snp.leading)
        }
        
        nextBtn.snp.makeConstraints {
            $0.top.equalTo(authNum.snp.bottom).offset(50)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(38)
        }
    }
}
