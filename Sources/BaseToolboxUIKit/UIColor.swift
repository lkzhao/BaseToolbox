//
//  File.swift
//  
//
//  Created by Luke Zhao on 11/20/21.
//

import UIKit

extension UIColor {
    public convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        let mask = 0x0000_00FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue = CGFloat(b) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    public convenience init(dark: UIColor, light: UIColor, elevatedDark: UIColor? = nil, elevatedLight: UIColor? = nil) {
        self.init { trait in
            if trait.userInterfaceLevel == .elevated {
                if trait.userInterfaceStyle == .dark {
                    return elevatedDark ?? dark
                } else {
                    return elevatedLight ?? light
                }
            } else {
                if trait.userInterfaceStyle == .dark {
                    return dark
                } else {
                    return light
                }
            }
        }
    }

    public var lightMode: UIColor {
        resolvedColor(with: UITraitCollection(userInterfaceStyle: .light))
    }

    public var darkMode: UIColor {
        resolvedColor(with: UITraitCollection(userInterfaceStyle: .dark))
    }

    public var isWhite: Bool {
        hexString == UIColor.white.hexString
    }

    public var inverted: UIColor {
        UIColor(dark: lightMode, light: darkMode)
    }

    public var alpha: CGFloat {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        return a
    }

    public var hexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        getRed(&r, green: &g, blue: &b, alpha: &a)

        let rgb: Int = (Int)(r * 255) << 16 | (Int)(g * 255) << 8 | (Int)(b * 255) << 0

        return String(format: "#%06x", rgb)
    }

    public func lighter(amount: CGFloat = 0.2) -> UIColor {
        return mixWithColor(UIColor.white, amount: amount)
    }

    public func darker(amount: CGFloat = 0.2) -> UIColor {
        return mixWithColor(UIColor.black, amount: amount)
    }

    public func mixWithColor(_ color: UIColor, amount: CGFloat = 0.25) -> UIColor {
        var r1: CGFloat = 0
        var g1: CGFloat = 0
        var b1: CGFloat = 0
        var alpha1: CGFloat = 0
        var r2: CGFloat = 0
        var g2: CGFloat = 0
        var b2: CGFloat = 0
        var alpha2: CGFloat = 0

        getRed(&r1, green: &g1, blue: &b1, alpha: &alpha1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha: &alpha2)
        return UIColor(
            red: r1 * (1.0 - amount) + r2 * amount,
            green: g1 * (1.0 - amount) + g2 * amount,
            blue: b1 * (1.0 - amount) + b2 * amount,
            alpha: alpha1)
    }

    public func dynamicMixWithColor(_ color: UIColor, amount: CGFloat = 0.25) -> UIColor {
        UIColor { trait in
            if trait.userInterfaceStyle == .dark {
                return self.darkMode.mixWithColor(color.darkMode, amount: amount)
            } else {
                return self.lightMode.mixWithColor(color.lightMode, amount: amount)
            }
        }
    }

    public var brightness: CGFloat {
        let originalCGColor = cgColor

        // Now we need to convert it to the RGB colorspace. UIColor.white / UIColor.black are greyscale and not RGB.
        // If you don't do this then you will crash when accessing components index 2 below when evaluating greyscale colors.
        let RGBCGColor = originalCGColor.converted(to: CGColorSpaceCreateDeviceRGB(), intent: .defaultIntent, options: nil)
        guard let components = RGBCGColor?.components else {
            return 0
        }
        guard components.count >= 3 else {
            return 0
        }

        return ((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000
    }

    public func isLight(threshold: CGFloat = 0.7) -> Bool {
        return brightness > threshold
    }
}
