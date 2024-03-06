//
//  TermsAndPrivacyButtons.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 5.03.24.
//

import SwiftUI

enum WebViewType {
    case termsOfService
    case privacyPolicy
}

struct TermsAndPrivacyButtons: View {
    // MARK: - Property -
    @Binding var showWebView: Bool
    @Binding var webViewType: WebViewType?

    private(set) var privacyURL = AppConstants.Info.privacy
    private(set) var termsURL = AppConstants.Info.terms

    // MARK: - Body -
    var body: some View {
        HStack(spacing: 3) {
            Button {
                webViewType = .termsOfService
                showWebView.toggle()
            } label: {
                Text(L10n.Onboarding.termsOfService)
                    .font(.appMedium(of: 12))
                    .foregroundColor(Color.appMarengo)
            }

            Text(L10n.Onboarding.and)
                .font(.appMedium(of: 12))
                .foregroundColor(Color.appManatee)

            Button {
                webViewType = .privacyPolicy
                showWebView.toggle()
            } label: {
                Text(L10n.Onboarding.privacyPolicy)
                    .font(.appMedium(of: 12))
                    .foregroundColor(Color.appMarengo)
            }
        }
        .sheet(isPresented: $showWebView) {
            switch webViewType {
            case .termsOfService:
                if let termsURL = URL(string: termsURL) {
                    WebView(url: termsURL)
                }
            case .privacyPolicy:
                if let privacyURL = URL(string: privacyURL) {
                    WebView(url: privacyURL)
                }
            case .none:
                EmptyView()
            }
        }
    }
}
