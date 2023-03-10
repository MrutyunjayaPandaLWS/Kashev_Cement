//
//  ColorExtention.swift
//  SuperStamp Project
//
//  Created by Arokia-M3 on 19/08/21.
//

import Foundation
import Foundation
import UIKit

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
class customColors {

    static var lightGrayCardColor:UIColor{
        get{
            return UIColor(hexString: "#858692")
        }
    }
    static var lightGrayCardColor2:UIColor{
        get{
            return UIColor(hexString: "#858692")
        }
    }
    static var tabItemSelectedColor:UIColor{
        get{
            return UIColor(hexString: "#5C50FF")
        }
    }
    static var tabItemNormalColor:UIColor{
        get{
            return UIColor(hexString: "#B9B9B9")
        }
    }
    static var bankRowNormalCellBorder:UIColor{
        get{
            return UIColor(hexString: "#DCE1E6").withAlphaComponent(0.45)
        }
    }
   
}
