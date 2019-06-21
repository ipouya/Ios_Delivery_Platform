//
//  Extensions.swift
//  Deliveries
//
//  Created by Pouya Ghasemi on 6/21/19.
//  Copyright © 2019 Deliveries. All rights reserved.
//


import UIKit

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(
            in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        var aaa: UInt32 = 255
        var rrr: UInt32 = 255
        var ggg: UInt32 = 255
        var bbb: UInt32 = 255
        switch hex.count {
        case 3: // RGB (12-bit)
            (aaa, rrr, ggg, bbb) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (aaa, rrr, ggg, bbb) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (aaa, rrr, ggg, bbb) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            print("Color Extention Error")
        }
        self.init(red: CGFloat(rrr) / 255.0, green: CGFloat(ggg) / 255.0, blue: CGFloat(bbb) / 255.0, alpha: CGFloat(aaa) / 255)
    }
}
