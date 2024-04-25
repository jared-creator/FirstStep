//
//  Color.swift
//  FirstStep
//
//  Created by JaredMurray on 4/18/24.
//

import SwiftUI
import UIKit

extension Color {
    func luminance() -> Double {
        // Convert SwiftUI Color to UIColor
        let uiColor = UIColor(self)
        
        // Extract RGB values
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        // Compute luminance.
        return 0.2126 * Double(red) + 0.7152 * Double(green) + 0.0722 * Double(blue)
    }
    
    func isLight() -> Bool {
        return luminance() > 0.5
    }
    
    func adaptedTextColor() -> Color {
        return isLight() ? Color.black : Color.white
    }
    
    static func convert(_ color: Color) -> UIColor {
        return UIColor(color)
    }
    
    init?(hex: String) {
        var localHex = hex.trimmingCharacters(in:.whitespacesAndNewlines)
        localHex = localHex.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        let len = localHex.count
        
        guard Scanner(string: localHex).scanHexInt64(&rgb) else { return nil }
        
        if len == 6 {
            red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            blue = CGFloat((rgb & 0x0000FF)) / 255.0
            alpha = 1.0
        } else if len == 8 {
            red = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            green = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            blue = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            alpha = CGFloat((rgb & 0x000000FF)) / 255.0
        } else {
            return nil
        }
        
        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
    
    func hexString() -> String {
          let components = self.cgColor?.components
          let r: CGFloat = components?[0] ?? 1.0
          let g: CGFloat = components?[1] ?? 0.0
          let b: CGFloat = components?[2] ?? 0.0

          let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
          return hexString
      }
}
