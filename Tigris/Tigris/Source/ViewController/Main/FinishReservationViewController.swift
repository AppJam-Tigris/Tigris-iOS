//
//  FinishReservationViewController.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/19.
//

import Foundation
import UIKit

class FinishReservationViewController: BaseViewController {
    private let info = UILabel().then {
        $0.text = "예약정보"
        $0.font = .init(name: Font.medium.rawValue, size: 15)
    }
    
    private let finish = UIImageView().then {
        $0.image = .init(named: "FinishImg")
        $0.contentMode = .scaleAspectFit
    }
    
    private let homeBtn = UIButton(type: .system).then {
        $0.setTitle("홈으로", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = MainColor.darkBlue
        $0.layer.cornerRadius = 15
    }
    
    override func setBtn() {
        homeBtn.rx.tap.subscribe(onNext: { _ in
            let vc = MainViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
    }
    
    override func setUpConstraints() {
        [info, finish, homeBtn].forEach{view.addSubview($0)}
        
        info.snp.makeConstraints {
            $0.top.equalToSuperview().inset(90)
            $0.leading.equalToSuperview().inset(59)
        }
        
        finish.snp.makeConstraints {
            $0.top.equalTo(info.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(311)
            $0.height.equalTo(400)
        }
        
        homeBtn.snp.makeConstraints {
            $0.top.equalTo(finish.snp.bottom).offset(58)
            $0.leading.trailing.equalToSuperview().inset(45)
            $0.height.equalTo(38)
        }
    }
}
