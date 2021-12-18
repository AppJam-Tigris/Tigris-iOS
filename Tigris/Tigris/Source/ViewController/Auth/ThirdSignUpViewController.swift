//
//  FirstSignUpViewController.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/18.
//

import Foundation

import UIKit

class ThirdSignUpViewController: BaseViewController {
    
    private let viewModel = ThirdSignUpViewModel()
    var birth = String()
    var gender = String()
    var nationality = String()
    var location = Location(address: nil, road_name: nil, details_address: nil)
    
    private let logo = UIImageView().then {
        $0.image = .init(named: "logoImg")
        $0.contentMode = .scaleAspectFit
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
        $0.titleLabel?.font = .systemFont(ofSize: 8)
        $0.layer.borderWidth = 0.5
        $0.backgroundColor = .white
    }
    
    private let idError = UILabel().then {
        $0.font = .init(name: Font.regular.rawValue, size: 8)
        $0.textColor = .red
    }
    
    private let pw = AuthView().then {
        $0.txt.placeholder = "PASSWORD(비밀번호)"
        $0.txt.font = .init(name: Font.regular.rawValue, size: 12)
    }
    
    private let checkPw = AuthView().then {
        $0.txt.placeholder = "PASSWORD CHECK(비밀번호 확인)"
        $0.txt.font = .init(name: Font.regular.rawValue, size: 12)
    }
    
    private let pwError = UILabel().then {
        $0.font = .init(name: Font.regular.rawValue, size: 8)
        $0.textColor = .red
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
        [logo, name, id, idCheckBtn, pw, checkPw, nextBtn].forEach{view.addSubview($0)}
    }
    
    override func bindViewModel() {
        let input = ThirdSignUpViewModel.Input(name: name.txt.rx.text.orEmpty.asDriver(onErrorJustReturn: ""),
                                               id: id.txt.rx.text.orEmpty.asDriver(),
                                               pw: pw.txt.rx.text.orEmpty.asDriver(),
                                               checkPw: checkPw.txt.rx.text.orEmpty.asDriver(),
                                               doneTap: idCheckBtn.rx.tap.asDriver())
        let output = viewModel.transform(input)
        
        output.isEnable.drive(nextBtn.rx.isEnabled).disposed(by: disposeBag)
        
        output.checkIdResult.asDriver(onErrorJustReturn: false).drive(onNext: { enable in
            if enable {
                self.idError.text = ""
                self.nextBtn.isEnabled = enable
                let alert = UIAlertController.init(title: "사용 가능한 아이디입니다.", message: "사용가능합니다.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            } else {
                self.idError.text = "아이디가 중복됩니다."
                self.nextBtn.isEnabled = enable
            }
        }).disposed(by: disposeBag)
        
    }
    
    override func setBtn() {
        nextBtn.rx.tap.subscribe(onNext: { [unowned self] _ in
            let vc = CheckPhoneViewController()
            vc.name = name.txt.text!
            vc.id = id.txt.text!
            vc.pw = pw.txt.text!
            vc.location.address = location.address
            vc.location.road_name = location.road_name
            vc.location.details_address = location.details_address
            vc.birth = birth
            vc.gender  = gender
            vc.nationality = nationality
            
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
    }
    
    override func setUpConstraints() {
        idCheckBtn.layer.cornerRadius = 5
        
        [name, id, pw, checkPw].forEach{
            $0.layer.addBorder([.bottom], color: .gray, width: 1)
        }
        
        logo.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(123)
            $0.height.equalTo(74)
        }
        
        name.snp.makeConstraints {
            $0.top.equalTo(logo.snp.bottom).offset(61)
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

extension ThirdSignUpViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if pw.txt.text != checkPw.txt.text {
            pwError.text = "비밀번호가 일치하지 않습니다."
        } else {
            pwError.text = ""
        }
    }
}
