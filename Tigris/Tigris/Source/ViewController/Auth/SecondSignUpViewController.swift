//
//  SecondSignUpViewController.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/19.
//

import Foundation
import UIKit

class SecondSignUpViewController: BaseViewController {
    
    private let viewModel = SecondSignUpViewModel()
    var birth = String()
    var gender = String()
    var nationality = String()
    var adress = String()
    var code = String()
    
    private let logo = UIImageView().then {
        $0.image = .init(named: "logoImg")
        $0.contentMode = .scaleAspectFit
    }
    
    private let postalCode = AuthView().then {
        $0.txt.placeholder = "Postal code(우편번호)"
        $0.eyesBtn.isHidden = true
    }
    
    private let postalCodeBtn = UIButton(type: .system).then {
        $0.setTitle("주소 찾기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 8)
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 5
    }
    
    private let address = AuthView().then {
        $0.txt.placeholder = "Address(주소지)"
        $0.eyesBtn.isHidden = true
    }
    
    private let detailAddress = AuthView().then {
        $0.txt.placeholder = "Detailed address(상세주소)"
        $0.eyesBtn.isHidden = true
    }
    
    private var nextBtn = UIButton(type: .system).then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 15
        $0.backgroundColor = MainColor.darkBlue
    }
    
    override func configureUI() {
        [logo, postalCode, postalCodeBtn, address, detailAddress, nextBtn]
            .forEach{view.addSubview($0)}
    }
    
    override func setNavigation() {
        self.navigationItem.title = "회원가입"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func bindViewModel() {
        let input = SecondSignUpViewModel.Input(address: postalCode.txt.rx.text.orEmpty.asDriver(),
                                                road_name: address.txt.rx.text.orEmpty.asDriver(),
                                                detailAddress: detailAddress.txt.rx.text.orEmpty.asDriver())
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.postalCode.txt.text = code
        self.address.txt.text = adress
    }
    
    override func setBtn() {
        nextBtn.rx.tap.subscribe(onNext: {[unowned self] _ in
            let vc = ThirdSignUpViewController()
            vc.location.address = postalCode.txt.text!
            vc.location.road_name = address.txt.text!
            vc.location.details_address = detailAddress.txt.text!
            vc.birth = birth
            vc.gender  = gender
            vc.nationality = nationality
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
        
        postalCodeBtn.rx.tap.subscribe(onNext: { _ in
            let vc = ViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
    }
    
    override func setUpConstraints() {
        [postalCode, address, detailAddress].forEach{$0.layer.addBorder([.bottom], color: .gray, width: 1)}
        logo.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
        }
        
        postalCode.snp.makeConstraints {
            $0.top.equalTo(logo.snp.bottom).offset(92)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(38)
        }
        
        postalCodeBtn.snp.makeConstraints {
            $0.centerY.equalTo(postalCode.txt)
            $0.trailing.equalTo(postalCode.snp.trailing).inset(5)
            $0.width.equalTo(48)
            $0.height.equalTo(12)
        }
        
        address.snp.makeConstraints {
            $0.top.equalTo(postalCode.snp.bottom).offset(38)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(38)
        }
        
        detailAddress.snp.makeConstraints {
            $0.top.equalTo(address.snp.bottom).offset(38)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(38)
        }
        
        nextBtn.snp.makeConstraints {
            $0.top.equalTo(detailAddress.snp.bottom).offset(93)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(38)
        }
    }
}
