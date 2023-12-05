//
//  Font+Extension.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 1.12.23.
//

import Foundation
import SwiftUI

extension Font {
    /// Gilroy-Bold.ttf
    static func gilroyBold(size: CGFloat) -> Font {
        return Font.custom("Gilroy-Bold", size: size)
    }
    /// Urbanist-Regular.ttf
    static func urbanistRegular(size: CGFloat) -> Font {
        return Font.custom("Urbanist-Regular", size: size)
    }
    /// Urbanist-Bold.ttf
    static func urbanistBold(size: CGFloat) -> Font {
        return Font.custom("Urbanist-Bold", size: size)
    }
    /// Urbanist-Light.ttf
    static func urbanistLight(size: CGFloat) -> Font {
        return Font.custom("Urbanist-Light", size: size)
    }
    /// Urbanist-Medium.ttf
    static func urbanistMedium(size: CGFloat) -> Font {
        return Font.custom("Urbanist-Medium", size: size)
    }
    /// Urbanist-SemiBold.ttf
    static func urbanistSemiBold(size: CGFloat) -> Font {
    return Font.custom("Urbanist-SemiBold", size: size)
}
}
