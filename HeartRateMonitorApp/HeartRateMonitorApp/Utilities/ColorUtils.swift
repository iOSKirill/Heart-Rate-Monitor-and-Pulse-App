//
//  ColorUtils.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 20.12.23.
//

import Foundation

// Typealias for RGB color values
typealias RGB = (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)

// Typealias for HSV color values
typealias HSV = (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat)

func hsv2rgb(_ hsv: HSV) -> RGB {
    // Converts HSV to a RGB color
    var rgb: RGB = (red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
    var r: CGFloat
    var g: CGFloat
    var b: CGFloat
    
    let i = Int(hsv.hue * 6)
    let f = hsv.hue * 6 - CGFloat(i)
    let p = hsv.brightness * (1 - hsv.saturation)
    let q = hsv.brightness * (1 - f * hsv.saturation)
    let t = hsv.brightness * (1 - (1 - f) * hsv.saturation)
    
    switch (i % 6) {
    case 0: 
        r = hsv.brightness
        g = t
        b = p
        break
    case 1: 
        r = q
        g = hsv.brightness
        b = p
        break
    case 2:
        r = p
        g = hsv.brightness
        b = t
        break
    case 3:
        r = p
        g = q
        b = hsv.brightness
        break
    case 4:
        r = t
        g = p
        b = hsv.brightness
        break
    case 5:
        r = hsv.brightness 
        g = p
        b = q
        break
    default:
        r = hsv.brightness
        g = t
        b = p
    }
    
    rgb.red = r
    rgb.green = g
    rgb.blue = b
    rgb.alpha = hsv.alpha
    return rgb
}
