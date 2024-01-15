//
//  OnboardingStep.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 9.01.24.
//

import Foundation

struct OnboardingStep: Hashable {
    let id: Int
    let image: ImageResource
    let title: String
    let description: String
}
