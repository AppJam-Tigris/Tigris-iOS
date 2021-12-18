//
//  SecondSignUpViewController.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/18.
//

import UIKit
import DropDown

class FirstSignUpViewController: BaseViewController {
    
    private let viewModel = FirstSignUpViewModel()
    
    private let logo = UIImageView().then {
        $0.image = .init(named: "logoImg")
        $0.contentMode = .scaleAspectFit
    }
    
    private let birth = AuthView().then {
        $0.txt.placeholder = "Birthday(생년월일)"
        $0.txt.font = .init(name: Font.regular.rawValue, size: 12)
        $0.eyesBtn.isHidden = true
    }
    
    private let gender = AuthView().then {
        $0.txt.placeholder = "Gender(성별)"
        $0.txt.font = .init(name: Font.regular.rawValue, size: 12)
        $0.eyesBtn.isHidden = true
    }
    
    private let genderBtn = UIButton(type: .system).then {
        $0.setTitle("성별", for: .normal)
        $0.setImage(.init(systemName: "chevron.down", withConfiguration: UIImage.SymbolConfiguration(pointSize: 10, weight: .regular, scale: .small)), for: .normal)
        $0.tintColor = .gray
        $0.semanticContentAttribute = .forceRightToLeft
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 8)
        $0.layer.borderWidth = 0.5
        $0.backgroundColor = .white
    }
    
    private let nationality = AuthView().then {
        $0.txt.placeholder = "Nationality(국적)"
        $0.txt.font = .init(name: Font.regular.rawValue, size: 12)
        $0.eyesBtn.isHidden = true
    }
    
    private let nationalityBtn = UIButton(type: .system).then {
        $0.setTitle("국적", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.setImage(.init(systemName: "chevron.down", withConfiguration: UIImage.SymbolConfiguration(pointSize: 10, weight: .regular, scale: .small)), for: .normal)
        $0.tintColor = .gray
        $0.semanticContentAttribute = .forceRightToLeft
        $0.titleLabel?.font = .systemFont(ofSize: 8)
        $0.layer.borderWidth = 0.5
        $0.backgroundColor = .white
    }
    
    private let nextBtn = UIButton(type: .system).then {
        $0.setTitle("다음", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = MainColor.darkBlue
        $0.layer.cornerRadius = 15
        $0.titleLabel?.font = .init(name: Font.medium.rawValue, size: 16)
    }
    
    private let genderDrop = DropDown().then {
        $0.width = 48
        $0.dataSource = ["남자", "여자"]
    }
    
    private let nationalityDrop = DropDown().then {
        $0.width = 48
        $0.dataSource = ["내국인", "외국인"]
        $0.textFont = .systemFont(ofSize: 12)
        $0.cornerRadius = 5
    }
    
    override func bindViewModel() {
        let input = FirstSignUpViewModel.Input(birth: birth.txt.rx.text.orEmpty.asDriver(),
                                         gender: gender.txt.rx.text.orEmpty.asDriver(),
                                         nationality: nationality.txt.rx.text.orEmpty.asDriver())
        
    }
    override func setNavigation() {
        self.navigationItem.title = "회원가입"
    }
    
    override func configureUI() {
        genderDrop.anchorView = genderBtn
        nationalityDrop.anchorView = nationalityBtn
        
        [logo, birth, gender, genderBtn,
        nationality, nationalityBtn,nextBtn].forEach{view.addSubview($0)}
        
        genderDrop.selectionAction = { [unowned self] (index: Int, item: String) in
                genderBtn.setTitle(item, for: .normal)
                gender.txt.text = item
        }
        
        nationalityDrop.selectionAction = {[unowned self] (index: Int, item: String) in
            nationality.txt.text = item
            nationalityBtn.setTitle(item, for: .normal)
        }
    }
    
    override func setBtn() {
        
        genderBtn.rx.tap.subscribe(onNext: {
            self.genderDrop.show()
        }).disposed(by: disposeBag)
        
        nationalityBtn.rx.tap.subscribe(onNext: {
            self.nationalityDrop.show()
        }).disposed(by: disposeBag)
        
        nextBtn.rx.tap.subscribe(onNext: {[unowned self] _ in
            let vc = SecondSignUpViewController()
            vc.birth = birth.txt.text!
            if gender.txt.text == "남자" {
                vc.gender = "MALE"
            } else {
                vc.gender = "FEMALE"
            }
            
            if nationality.txt.text == "내국인" {
                vc.nationality = "LOCAL"
            } else {
                vc.nationality = "FOREIGN"
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func setUpConstraints() {
        
        [genderDrop, nationalityDrop].forEach{
            $0.bottomOffset = CGPoint(x: 0, y:($0.anchorView?.plainView.bounds.height)!)}
        
        [genderBtn, nationalityBtn].forEach{$0.layer.cornerRadius = 5}
        
        [birth, gender, nationality].forEach{
            $0.layer.addBorder([.bottom], color: .gray, width: 1)
        }
        
        logo.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(123)
            $0.height.equalTo(74)
        }
        
        birth.snp.makeConstraints {
            $0.top.equalTo(logo.snp.bottom).offset(61)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(30)
        }
        
        gender.snp.makeConstraints {
            $0.top.equalTo(birth.snp.bottom).offset(38)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(30)
        }
        
        genderBtn.snp.makeConstraints {
            $0.centerY.equalTo(gender)
            $0.trailing.equalTo(gender.snp.trailing).inset(5)
            $0.width.equalTo(48)
            $0.height.equalTo(12)
        }
        
        nationality.snp.makeConstraints {
            $0.top.equalTo(gender.snp.bottom).offset(38)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(30)
        }
        
        nationalityBtn.snp.makeConstraints {
            $0.centerY.equalTo(nationality)
            $0.trailing.equalTo(gender.snp.trailing).inset(5)
            $0.width.equalTo(48)
            $0.height.equalTo(12)
        }
        
        nextBtn.snp.makeConstraints {
            $0.top.equalTo(nationality.snp.bottom).offset(92)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(40)
        }
    }
}
