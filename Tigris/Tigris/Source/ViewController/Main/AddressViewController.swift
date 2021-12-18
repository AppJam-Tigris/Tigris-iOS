//
//  AddressViewController.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/19.
//

import Foundation
import UIKit

class AddressViewController: BaseViewController {
    
    private let searchBar = UISearchBar().then {
        $0.setImage(UIImage(), for: UISearchBar.Icon.search, state: .normal)
        $0.tintColor = .black
        $0.searchTextField.placeholder = "주소를 입력하세요"
        $0.searchTextField.backgroundColor = .clear
        $0.searchTextField.font = .init(name: Font.medium.rawValue, size: 16)
        $0.layer.addBorder([.bottom], color: MainColor.dark, width: 1)
    }
    
    private let tableView = UITableView().then {
        $0.backgroundColor = MainColor.gray
    }
    
    override func viewDidLoad() {
        tableView.register(AddressTableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.delegate = self
//        tableView.dataSource = self
    }
    
    override func setNavigation() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 68, height: 38))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "logoImg")
        imageView.image = image
        navigationItem.titleView = imageView
    }
    
    override func configureUI() {
        [searchBar, tableView].forEach{view.addSubview($0)}
    }
    
    override func setUpConstraints() {
        searchBar.layer.addBorder([.bottom], color: MainColor.darkBlue, width: 1)
        
        searchBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(100)
            $0.leading.trailing.equalToSuperview().inset(35)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(7)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
    }
}
//
//extension AddressViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
//
//
//}
