//
//  Font+Extension.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 9.12.23.
//

import SwiftUI

extension SwiftUI.Font {
    static func appGilroyBold(of size: CGFloat) -> SwiftUI.Font {
        FontFamily.Gilroy.bold.swiftUIFont(size: size)
    }
    
    static func appUrbanistBold(of size: CGFloat) -> SwiftUI.Font {
        FontFamily.Urbanist.bold.swiftUIFont(size: size)
    }
    
    static func appSemibold(of size: CGFloat) -> SwiftUI.Font {
        FontFamily.Urbanist.semiBold.swiftUIFont(size: size)
    }
    
    static func appMedium(of size: CGFloat) -> SwiftUI.Font {
        FontFamily.Urbanist.medium.swiftUIFont(size: size)
    }
}
