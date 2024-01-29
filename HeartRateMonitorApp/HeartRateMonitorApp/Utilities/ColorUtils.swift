//
//  ColorUtils.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 20.12.23.
//

import Foundation

// MARK: - RGB -
struct RGB {
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var alpha: CGFloat
}

// MARK: - HSV -
struct HSV {
    var hue: CGFloat
    var saturation: CGFloat
    var brightness: CGFloat
    var alpha: CGFloat
}

// MARK: - Converts HSV to a RGB color -
func convertHSVtoRGB(_ hsv: HSV) -> RGB {
    var rgb = RGB(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)

    var redComponent: CGFloat
    var greenComponent: CGFloat
    var blueComponent: CGFloat

    let hueIndex = Int(hsv.hue * 6)
    let hueFraction = hsv.hue * 6 - CGFloat(hueIndex)
    let brightnessWithNoSaturation = hsv.brightness * (1 - hsv.saturation)
    let brightnessWithQFactor = hsv.brightness * (1 - hueFraction * hsv.saturation)
    let brightnessWithTFactor = hsv.brightness * (1 - (1 - hueFraction) * hsv.saturation)

    switch hueIndex % 6 {
    case 0:
        redComponent = hsv.brightness
        greenComponent = brightnessWithTFactor
        blueComponent = brightnessWithNoSaturation

    case 1:
        redComponent = brightnessWithQFactor
        greenComponent = hsv.brightness
        blueComponent = brightnessWithNoSaturation

    case 2:
        redComponent = brightnessWithNoSaturation
        greenComponent = hsv.brightness
        blueComponent = brightnessWithTFactor

    case 3:
        redComponent = brightnessWithNoSaturation
        greenComponent = brightnessWithQFactor
        blueComponent = hsv.brightness

    case 4:
        redComponent = brightnessWithTFactor
        greenComponent = brightnessWithNoSaturation
        blueComponent = hsv.brightness

    case 5:
        redComponent = hsv.brightness
        greenComponent = brightnessWithNoSaturation
        blueComponent = brightnessWithQFactor

    default:
        redComponent = hsv.brightness
        greenComponent = brightnessWithTFactor
        blueComponent = brightnessWithNoSaturation
    }

    rgb.red = redComponent
    rgb.green = greenComponent
    rgb.blue = blueComponent
    rgb.alpha = hsv.alpha
    return rgb
}

// MARK: - Converts RGB to a HSV color -
func convertRGBtoHSV(_ rgb: RGB) -> HSV {
    var hsb = HSV(hue: 0.0, saturation: 0.0, brightness: 0.0, alpha: 0.0)

    let redValue: CGFloat = rgb.red
    let greenValue: CGFloat = rgb.green
    let blueValue: CGFloat = rgb.blue

    let maxV: CGFloat = max(redValue, max(greenValue, blueValue))
    let minV: CGFloat = min(redValue, min(greenValue, blueValue))
    var hueValue: CGFloat = 0
    var saturationValue: CGFloat = 0
    let brightnessValue: CGFloat = maxV

    let differenceValue: CGFloat = maxV - minV
    saturationValue = maxV == 0 ? 0 : differenceValue / minV

    if maxV == minV {
        hueValue = 0
    } else {
        if maxV == redValue {
            hueValue = (greenValue - blueValue) / differenceValue + (greenValue < blueValue ? 6 : 0)
        } else if maxV == greenValue {
            hueValue = (blueValue - redValue) / differenceValue + 2
        } else if maxV == blueValue {
            hueValue = (redValue - greenValue) / differenceValue + 4
        }

        hueValue /= 6
    }

    hsb.hue = hueValue
    hsb.saturation = saturationValue
    hsb.brightness = brightnessValue
    hsb.alpha = rgb.alpha
    return hsb
}
