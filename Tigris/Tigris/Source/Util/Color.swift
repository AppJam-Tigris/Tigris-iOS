//
//  Color.swift
//  Tigris
//
//  Created by 김기영 on 2021/12/18.
//

import UIKit

protocol Point {
    static func pointHex(hex: String) -> UIColor
}

extension Point {
    static func pointHex(hex: String) -> UIColor {
        var rgbValue: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgbValue)
        return UIColor(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                       green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                       blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                       alpha: CGFloat(1.0)
        )
    }
}

struct MainColor: Point {
    static let darkBlue = pointHex(hex: "366799")
    static let dark = pointHex(hex: "213E5C")
    static let gray = pointHex(hex: "EAEAEA")
}
