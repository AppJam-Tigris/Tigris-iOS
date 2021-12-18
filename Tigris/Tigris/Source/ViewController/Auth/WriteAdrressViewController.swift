//
//  WriteAdrressViewController.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/19.
//

import Foundation
import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    let webView = WKWebView()
    
    override func viewDidLoad() {
        view.addSubview(webView)
        webView.navigationDelegate = self

        let url = URL(string: "https://postcode.pocketlesson.io")!
        webView.load(URLRequest(url: url))
    }
    
    override func viewDidLayoutSubviews() {
        webView.snp.makeConstraints {
            $0.top.equalTo(view.snp.top)
            $0.leading.trailing.equalTo(view)
            $0.bottom.equalTo(view.snp.bottom)
        }
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
      switch navigationAction.request.url?.scheme {
      case "postcode":
        if let urlString = navigationAction.request.url?.absoluteString {
          let components = URLComponents(string: urlString)
          let address = components?.queryItems?.first { $0.name == "address" }?.value
          let zonecode = components?.queryItems?.first { $0.name == "zonecode" }?.value
        let vc = SecondSignUpViewController()
            vc.adress = address!
            vc.code = zonecode!
            self.navigationController?.pushViewController(vc, animated: true)
        }
        decisionHandler(.cancel)

      default:
        decisionHandler(.allow)
      }
    }
}
