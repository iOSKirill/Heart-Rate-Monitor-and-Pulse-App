//
//  SubscriptionViewModel.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 5.03.24.
//

import Foundation
import SwiftUI

enum SubscriptionType {
    case monthly
    case weekly
    case yearly
}

final class SubscriptionViewModel: ObservableObject {
    // MARK: - Property -
    @Published var isChoosingSubscription: Bool = false
    @Published var selectedSubscription: SubscriptionType = .weekly
    @Published var webViewType: WebViewType? = .none
    @Published var showWebView = false

    private(set) var blueGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color.appBlueGradientFirstButton,
            Color.appBlueGradientSecondButton
        ]),
        startPoint: .top,
        endPoint: .bottom
    )
}
