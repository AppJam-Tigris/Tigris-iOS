//
//  MainViewController.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/18.
//

import Foundation
import UIKit

class MainViewController: BaseViewController {
    
    private let logoImg = UIImageView().then {
        $0.image = .init(named: "titleImg")
        $0.contentMode = .scaleAspectFit
    }
    
    private let mapImg = UIImageView().then {
        $0.image = .init(named: "mapImg")
        $0.contentMode = .scaleAspectFit
    }
    
    private let findBtn = UIButton(type: .system).then {
        $0.backgroundColor = MainColor.darkBlue
        $0.layer.cornerRadius = 15
        $0.setTitle("진료소 찾기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
    }
    
    override func setBtn() {
        findBtn.rx.tap.subscribe(onNext: {
            let vc = AddressViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
    }
    
    override func setUpConstraints() {
        [logoImg, mapImg, findBtn].forEach{view.addSubview($0)}
        
        logoImg.snp.makeConstraints {
            $0.top.equalToSuperview().inset(90)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(116)
            $0.height.equalTo(38)
        }
        
        mapImg.snp.makeConstraints {
            $0.top.equalTo(logoImg.snp.bottom).offset(11)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(323)
            $0.height.equalTo(423)
        }
        
        findBtn.snp.makeConstraints {
            $0.top.equalTo(mapImg.snp.bottom).offset(52)
            $0.leading.trailing.equalToSuperview().inset(45)
            $0.height.equalTo(38)
        }
    }
}


