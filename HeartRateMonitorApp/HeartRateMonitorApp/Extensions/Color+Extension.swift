//
//  Color+Extension.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 30.11.23.
//

import Foundation
import SwiftUI

public extension Color {
    /// #4F606D
    var highlightedButton: Color {
        Color("HighlightedButton")
    }
    /// #95A4B6
    var notHighlightedButton: Color {
        Color("NotHighlightedButton")
    }
    /// #9FA5AE
    var backgroundSreens: Color {
        Color("BackgroundSreens")
    }
    /// #4F606D
    var mainText: Color {
        Color("MainText")
    }
    /// #44A8E1
    var currentDay: Color {
        Color("CurrentDay")
    }
    /// #CBDBE7
    var measureDashboardSubtitle: Color {
        Color("MeasureDashboardSubtitle")
    }
    /// #678093
    var subtitle: Color {
        Color("Subtitle")
    }
    /// #55BDE0
    var blueGradientFirstButton: Color {
        Color("BlueGradientFirstButton")
    }
    /// #217BD9
    var blueGradientSecondButton: Color {
        Color("BlueGradientSecondButton")
    }
    /// #FF7575
    var redGradientFirstButton: Color {
        Color("RedGradientFirstButton")
    }
    /// #F03F38
    var redGradientSecondButton: Color {
        Color("RedGradientSecondButton")
    }
    /// #F2F3F4
    var settingsButtonBackground: Color {
        Color("SettingsButtonBackground")
    }
    /// #2480E6
    var shadowButton: Color {
        Color("ShadowButton")
    }
    /// #FF4C4C
    var progressBarRed: Color {
        Color("ProgressBarRed")
    }
}
