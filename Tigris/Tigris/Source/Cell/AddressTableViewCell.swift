//
//  AddressTableViewCell.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/19.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    
    let cellView = UIView().then{
        $0.backgroundColor = .white
    }
    
    let roadMain = UILabel().then {
        $0.font = .init(name: Font.medium.rawValue, size: 10)
    }
    
    let address = UILabel().then {
        $0.font = .init(name: Font.medium.rawValue, size: 10)
        $0.textColor = .white
        $0.backgroundColor = MainColor.darkBlue
        $0.text = "주소"
    }
    
    let addressTxt = UILabel().then {
        $0.font = .init(name: Font.regular.rawValue, size: 8)
        $0.textColor = .gray
    }
    
    let postalNum = UILabel().then {
        $0.font = .init(name: Font.medium.rawValue, size: 10)
        $0.textColor = .white
        $0.backgroundColor = MainColor.darkBlue
        $0.text = "번호"
    }
    
    let postalNumTxt = UILabel().then {
        $0.font = .init(name: Font.regular.rawValue, size: 8)
        $0.textColor = .gray
    }
    
    let choice = UILabel().then {
        $0.backgroundColor = MainColor.darkBlue
        $0.text = "선택"
        $0.font = .init(name: Font.medium.rawValue, size: 10)
        $0.textColor = .white
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setup() {
        [cellView, roadMain, address, addressTxt, postalNum, postalNumTxt, choice]
            .forEach{self.addSubview($0)}
        
        cellView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(4)
            $0.leading.trailing.equalToSuperview().inset(13)
            $0.height.equalTo(60)
        }
        
        roadMain.snp.makeConstraints {
            $0.top.equalTo(cellView.snp.top).inset(6)
            $0.leading.equalTo(cellView.snp.leading).inset(9)
        }
        
        address.snp.makeConstraints {
            $0.top.equalTo(roadMain.snp.bottom).offset(4)
            $0.leading.equalTo(cellView.snp.leading).inset(10)
            $0.width.equalTo(37)
            $0.height.equalTo(14)
        }
        
        addressTxt.snp.makeConstraints {
            $0.centerY.equalTo(address)
            $0.leading.equalTo(address.snp.trailing).offset(8)
        }
        
        postalNum.snp.makeConstraints {
            $0.top.equalTo(address.snp.bottom).offset(5)
            $0.leading.equalTo(cellView.snp.leading).inset(10)
            $0.bottom.equalTo(cellView.snp.bottom).inset(7)
            $0.width.equalTo(37)
            $0.height.equalTo(14)
        }
        
        postalNumTxt.snp.makeConstraints {
            $0.centerY.equalTo(postalNum)
            $0.leading.equalTo(address.snp.trailing).offset(8)
        }
        
        choice.snp.makeConstraints {
            $0.centerY.equalTo(cellView)
            $0.trailing.equalTo(cellView.snp.trailing).inset(12)
            $0.width.equalTo(37)
            $0.height.equalTo(14)
        }
    }

}
