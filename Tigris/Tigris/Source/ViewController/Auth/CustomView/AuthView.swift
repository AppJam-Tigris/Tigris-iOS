//
//  AuthView.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/18.
//

import UIKit
import Then
import SnapKit

class AuthView: UIView {
    
    private var clickBtn = false
    
    let authView = UIView().then {
        $0.backgroundColor = .white
    }
    
    let txt = UITextField().then {
        $0.font = UIFont.init(name: Font.regular.rawValue, size: 12)
    }
    
    let eyesBtn = UIButton().then {
        $0.setImage(.init(systemName: "eye.fill"), for: .normal)
        $0.tintColor = .gray
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        eyes()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        [authView, txt, eyesBtn].forEach{self.addSubview($0)}
        
        authView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        
        txt.snp.makeConstraints {
            $0.top.equalTo(authView.snp.top).inset(7)
            $0.leading.trailing.equalToSuperview().inset(12)
        }
        
        eyesBtn.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
            $0.height.width.equalTo(24)
        }
    }
    
    private func eyes() {
        if clickBtn {
            eyesBtn.setImage(.init(systemName: "eye.fill"), for: .normal)
            txt.isSecureTextEntry = false
            clickBtn.toggle()
        }
        else {
            eyesBtn.setImage(.init(systemName: "eye.slash.fill"), for: .normal)
            txt.isSecureTextEntry = true
            clickBtn.toggle()
        }
    }
}
