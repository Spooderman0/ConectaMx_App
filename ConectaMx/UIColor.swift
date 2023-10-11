//
//  UIColor.swift
//  ConectaMx
//
//  Created by Danna Valencia on 09/10/23.
//

import Foundation
import SwiftUI

extension UIColor {
    convenience init(hex: String) {
        let hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let hexString: String

        if hexSanitized.hasPrefix("#") {
            hexString = String(hexSanitized.dropFirst())
        } else {
            hexString = hexSanitized
        }

        var color: UInt64 = 0

        Scanner(string: hexString).scanHexInt64(&color)

        let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(color & 0x0000FF) / 255.0

        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}

