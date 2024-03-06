//
//  OnboardingViewModel.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 9.01.24.
//

import Foundation
import SwiftUI
import WebKit

final class OnboardingViewModel: ObservableObject {
    // MARK: - Property -
    @AppStorage("appCondition", store: .standard) var appCondition: AppCondition = .onboardingView
    @Published var currentStep: Int = 0
    @Published var onboardingSteps = [
        OnboardingStep(id: 0,
                       image: .onboardingStepOne,
                       title: L10n.Onboarding.StepOne.title,
                       description: L10n.Onboarding.StepOne.subtitle),
        OnboardingStep(id: 1,
                       image: .onboardingStepTwo,
                       title: L10n.Onboarding.StepTwo.title,
                       description: L10n.Onboarding.StepTwo.subtitle),
        OnboardingStep(id: 2,
                       image: .onboardingStepThree,
                       title: L10n.Onboarding.StepThree.title,
                       description: L10n.Onboarding.StepThree.subtitle),
        OnboardingStep(id: 3,
                       image: nil,
                       title: L10n.Onboarding.Paywall.title,
                       description: L10n.Onboarding.Paywall.subtitle)
    ]
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

    // MARK: - Next step onboarding -
    func nextStepOnButton() {
        if currentStep < onboardingSteps.count - 1 {
            currentStep += 1
        } else {
            appCondition = .homeHealthView
        }
    }

    // MARK: - Get next button text -
    func getNextButtonText() -> String {
        currentStep == 0 ? "Go" : "Next"
    }
}

// MARK: - WebView terms and privacy info -
struct WebView: UIViewRepresentable {
    var url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let requst = URLRequest(url: url)
        webView.load(requst)
    }
}
