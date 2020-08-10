//
//  UIColorExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/9.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension UIColor {
    @objc static func color(r: Int, g: Int, b: Int, alpha: CGFloat = 1) -> UIColor {
        return UIColor(r: r, g: g, b: b, alpha: alpha)
    }
    
    @objc convenience init(r: Int, g: Int, b: Int, alpha: CGFloat = 1) {
        var trans = alpha
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }

        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: trans)
    }
    
    @objc func color(hexString: String, alpha: CGFloat = 1) -> UIColor {
        return UIColor(hexString: hexString, alpha: alpha)
    }
        
    @objc convenience init(hexString: String, alpha: CGFloat = 1) {
        var string = ""
        if hexString.lowercased().hasPrefix("0x") {
            string =  hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }

        if string.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }

        let hexValue = Int(string, radix: 16) ?? 0
        var trans = alpha
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        let red = (hexValue >> 16) & 0xff
        let green = (hexValue >> 8) & 0xff
        let blue = hexValue & 0xff
        self.init(r: red, g: green, b: blue, alpha: trans)
    }
    
    /// UIColor 的 RGB A 成分  (0 和 255之间).
    var rgbComponents: (red: Int, green: Int, blue: Int, alpha: Int) {
        let components: [CGFloat] = {
            let comps: [CGFloat] = cgColor.components!
            guard comps.count != 4 else { return comps }
            return [0, 0, 0, 0]
        }()
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        let alpha = components[3]
        return (red: Int(red * 255.0), green: Int(green * 255.0), blue: Int(blue * 255.0), alpha: Int(alpha * 255.0))
    }
    
    /// UIColor 的 RGB A 成分  (0 和 255之间). [red green blue alpha]
    @objc var rgbComponentsArray: [Int] {
        let tuple = rgbComponents
        return [tuple.red, tuple.green, tuple.blue, tuple.alpha]
    }

    /// hue(色调) saturation(饱和度), brightness(亮度), alpha(透明度).
    var hsbaComponents: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0

        getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return (hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    
    @objc var hsbaComponentsArray: [CGFloat] {
        let tuple = hsbaComponents
        return [tuple.hue, tuple.saturation, tuple.brightness, tuple.alpha]
    }

    @objc var hexString: String {
        let components: [Int] = {
            let comps = cgColor.components!.map { Int($0 * 255.0) }
            guard comps.count != 4 else { return comps }
            return [comps[0], comps[0], comps[0], comps[1]]
        }()
        return String(format: "#%02X%02X%02X", components[0], components[1], components[2])
    }
    
    @objc var alpha: CGFloat {
        return cgColor.alpha
    }
    
    /// 互补色
    @objc var complementary: UIColor? {
        let colorSpaceRGB = CGColorSpaceCreateDeviceRGB()
        let convertColorToRGBSpace: ((_ color: UIColor) -> UIColor?) = { color -> UIColor? in
            if self.cgColor.colorSpace!.model == CGColorSpaceModel.monochrome {
                let oldComponents = self.cgColor.components
                let components: [CGFloat] = [ oldComponents![0], oldComponents![0], oldComponents![0], oldComponents![1]]
                let colorRef = CGColor(colorSpace: colorSpaceRGB, components: components)
                let colorOut = UIColor(cgColor: colorRef!)
                return colorOut
            } else {
                return self
            }
        }

        let color = convertColorToRGBSpace(self)
        guard let componentColors = color?.cgColor.components else { return nil }

        let red: CGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[0]*255), 2.0))/255
        let green: CGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[1]*255), 2.0))/255
        let blue: CGFloat = sqrt(pow(255.0, 2.0) - pow((componentColors[2]*255), 2.0))/255

        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
