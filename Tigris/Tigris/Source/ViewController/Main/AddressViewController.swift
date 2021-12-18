//
//  AddressViewController.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/19.
//

import Foundation
import UIKit
import SnapKit

class AddressViewController: BaseViewController {
    
    private let viewModel = WriteAddressViewModel()
    private let searchView = UIView()
    
    private let searchTxt = UITextField().then{
        $0.placeholder = "진료소 검색"
        $0.font = .init(name: Font.medium.rawValue, size: 16)
    }
    
    private let searchBtn = UIButton(type: .system).then {
        $0.setImage(.init(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = MainColor.dark
    }
    
    private let tableView = UITableView().then {
        $0.backgroundColor = MainColor.gray
    }
    
    private let btn = UIButton(type: .system).then {
        $0.setTitle("예약하기", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = MainColor.darkBlue
        $0.layer.cornerRadius = 15
    }
    
    override func viewDidLoad() {
        tableView.register(AddressTableViewCell.self, forCellReuseIdentifier: "cell")
        view.backgroundColor = .white
    }
    
    override func bindViewModel() {
        let input = WriteAddressViewModel.Input(keyWord: searchTxt.rx.text.orEmpty.asDriver(),
                                                tap: searchBtn.rx.tap.asDriver())
        
        let output = viewModel.transform(input)
        
        output.posts.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: AddressTableViewCell.self)) { row, items, cell in
            cell.roadMain.text! = items.name
            cell.addressTxt.text! = items.address
            cell.postalNumTxt.text! = items.manager_phone_number
        }.disposed(by: disposeBag)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func setNavigation() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 68, height: 38))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logoImg")
        imageView.image = image
        navigationItem.titleView = imageView
    }
    
    override func setUpConstraints() {
        [searchView, searchTxt, searchBtn, tableView, btn].forEach{view.addSubview($0)}
        searchView.layer.addBorder([.bottom], color: MainColor.darkBlue, width: 1)
        
        searchView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.trailing.equalToSuperview().inset(35)
            $0.height.equalTo(40)
        }
        
        searchTxt.snp.makeConstraints {
            $0.top.equalTo(searchView.snp.top).inset(0)
            $0.left.trailing.equalToSuperview().inset(35)
            $0.height.equalTo(35)
        }
        
        searchBtn.snp.makeConstraints {
            $0.centerY.equalTo(searchTxt)
            $0.trailing.equalTo(searchTxt.snp.trailing).inset(5)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchView.snp.bottom).inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(450)
        }
        
        btn.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom).offset(55)
            $0.leading.trailing.equalToSuperview().inset(45)
            $0.height.equalTo(38)
        }
    }
}
