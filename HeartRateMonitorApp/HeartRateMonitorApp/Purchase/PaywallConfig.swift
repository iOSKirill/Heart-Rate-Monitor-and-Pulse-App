//
//  PaywallConfig.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 22.01.24.
//

import Foundation
import ApphudSDK

struct PaywallConfig {
    let closeButtonDelay: Double
    let closeButtonAlpha: CGFloat

    let onboardingButtonTitle: String

    let trialTitle: String
    let trialSubtitle: String
    let trialButtonTitle: String

    let paywallTitle: String
    let paywallSubtitle: String
    let paywallButtonTitle: String

    let isPagingEnabled: Bool
    let isReviewEnabled: Bool
    let isBoldPrice: Bool

    static func `default`() -> PaywallConfig {
        .init(closeButtonDelay: 0,
              closeButtonAlpha: 1,
              onboardingButtonTitle: "",
              trialTitle: "",
              trialSubtitle: "",
              trialButtonTitle: "",
              paywallTitle: "",
              paywallSubtitle: "",
              paywallButtonTitle: "",
              isPagingEnabled: false,
              isReviewEnabled: true,
              isBoldPrice: true
        )
    }
}
