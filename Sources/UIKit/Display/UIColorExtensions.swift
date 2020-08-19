//
//  UIColorExtensions.swift
//  SwiftExtensions
//
//  Created by jinbo on 2020/8/9.
//  Copyright © 2020 SwiftExtensions. All rights reserved.
//

import UIKit

public extension UIColor {
    @objc static func whiteWithAlpha(_ alpha: CGFloat) -> UIColor {
        return UIColor.white.withAlphaComponent(alpha)
    }
    
    @objc static func blackWithAlpha(_ alpha: CGFloat) -> UIColor {
        return UIColor.black.withAlphaComponent(alpha)
    }
    
    /// 使用整形的颜色 component 初始化
    @objc convenience init(componentRed: Int, green: Int, blue: Int, alpha: Int = 255) {
        let redValue = CGFloat(componentRed) / 255.0
        let greenValue = CGFloat(green) / 255.0
        let blueValue = CGFloat(blue) / 255.0
        let alphaValue = CGFloat(alpha) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue, alpha: alphaValue)
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
        let red = (hexValue >> 16) & 0xff
        let green = (hexValue >> 8) & 0xff
        let blue = hexValue & 0xff
        self.init(componentRed: red, green: green, blue: blue, alpha: Int(alpha * 255))
    }
    
    /// UIColor 的 RGB A 成分  (0 和 255之间).
    var rgbaComponents: (red: Int, green: Int, blue: Int, alpha: Int) {
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
    
    /// 颜色的红色成分
    @objc var redComponent: Int {
        let tuple = rgbaComponents
        return tuple.red
    }
    
    @objc var greenComponent: Int {
        let tuple = rgbaComponents
        return tuple.green
    }
    
    @objc var blueComponent: Int {
        let tuple = rgbaComponents
        return tuple.blue
    }
    
    @objc var alphaComponent: Int {
        let tuple = rgbaComponents
        return tuple.alpha
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
    
    /// 获得互补色
    @objc var complementaryColor: UIColor? {
        let colorSpaceRGB = CGColorSpaceCreateDeviceRGB()
        let convertColorToRGBSpace: ((_ color: UIColor) -> UIColor?) = { color -> UIColor? in
            if self.cgColor.colorSpace!.model == CGColorSpaceModel.monochrome {
                let oldComponents = self.cgColor.components
                let components: [CGFloat] = [oldComponents![0], oldComponents![0],
                                             oldComponents![0], oldComponents![1]]
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
