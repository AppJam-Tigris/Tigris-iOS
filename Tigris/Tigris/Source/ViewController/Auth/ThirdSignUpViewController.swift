//
//  SignUpViewController.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/18.
//

import UIKit
import DropDown

class ThirdSignUpViewController: BaseViewController {
    
    private let logo = UIImageView().then {
        $0.image = .init(named: "logoImg")
        $0.contentMode = .scaleAspectFit
    }
    
    private let label = UILabel().then {
        $0.text = "편한 코로나 선별진료소"
        $0.font = .init(name: Font.medium.rawValue, size: 14)
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
        $0.titleLabel?.font = .init(name: Font.regular.rawValue, size: 8)
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
        $0.titleLabel?.font = .init(name: Font.regular.rawValue, size: 8)
        $0.layer.borderWidth = 0.5
        $0.backgroundColor = .white
    }
    
    private let location = AuthView().then {
        $0.txt.placeholder = "Location(주소 찾기)"
        $0.txt.font = .init(name: Font.regular.rawValue, size: 12)
        $0.eyesBtn.isHidden = true
    }
    
    private let locationBtn = UIButton(type: .system).then {
        $0.setTitle("주소 찾기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.setImage(.init(systemName: "chvron.down"), for: .normal)
        $0.semanticContentAttribute = .forceRightToLeft
        $0.titleLabel?.font = .init(name: Font.regular.rawValue, size: 8)
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
    
    override func setNavigation() {
        self.navigationItem.title = "회원가입"
    }
    
    override func configureUI() {
        genderDrop.anchorView = genderBtn
        nationalityDrop.anchorView = nationalityBtn
        
        [logo, label, birth, gender, genderBtn,
        nationality, nationalityBtn, location, locationBtn, nextBtn].forEach{view.addSubview($0)}
        
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
        
    }
    
    override func setUpConstraints() {
        
        [genderDrop, nationalityDrop].forEach{
            $0.bottomOffset = CGPoint(x: 0, y:($0.anchorView?.plainView.bounds.height)!)}
        
        [genderBtn, nationalityBtn, locationBtn].forEach{$0.layer.cornerRadius = 5}
        
        [birth, gender, nationality, location].forEach{
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
        
        birth.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(61)
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
        
        location.snp.makeConstraints {
            $0.top.equalTo(nationality.snp.bottom).offset(38)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(30)
        }
        
        locationBtn.snp.makeConstraints {
            $0.centerY.equalTo(location)
            $0.trailing.equalTo(location.snp.trailing).inset(5)
            $0.width.equalTo(48)
            $0.height.equalTo(12)
        }
        
        nextBtn.snp.makeConstraints {
            $0.top.equalTo(location.snp.bottom).offset(78)
            $0.leading.trailing.equalToSuperview().inset(44)
            $0.height.equalTo(40)
        }
    }
}

import SwiftUI

struct ViewControllerRepresentable1: UIViewControllerRepresentable {
    typealias UIViewControllerType = SecondSignUpViewController

    func makeUIViewController(context: Context) -> SecondSignUpViewController {
        return SecondSignUpViewController()
    }
    func updateUIViewController(_ uiViewController: SecondSignUpViewController, context: Context) {
    }
}

@available(iOS 13.0.0, *)
struct ViewPreview1: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable1()
    }
}
