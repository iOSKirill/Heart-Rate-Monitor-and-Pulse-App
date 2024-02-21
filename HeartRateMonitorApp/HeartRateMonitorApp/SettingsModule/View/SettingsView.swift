//
//  SettingsView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 4.12.23.
//

import SwiftUI
import MessageUI
import StoreKit

struct SettingsView: View {
    // MARK: - Property -
    @StateObject var viewModel = SettingsViewModel()
    @Environment(\.dismiss) var dismiss
    @Environment(\.requestReview) var requestReview
    @Binding var showTabBar: Bool

    // MARK: - Body -
    var body: some View {
        ZStack(alignment: .top) {
            Color(.appPaleBlue).ignoresSafeArea()
            VStack(spacing: 12) {
                VStack {
                    VStack(spacing: 14) {
                        CustomSettingsButton(
                            image: .settingsContactUsIcon,
                            title: L10n.Settings.ContactUs.title,
                            action: { viewModel.state = .contactUs; viewModel.toggleState() }
                        )

                        Divider()
                            .padding(.leading, 32)

                        CustomSettingsButton(
                            image: .settingsPrivacyPolicyIcon,
                            title: L10n.Settings.PrivacPolicy.title,
                            action: { viewModel.state = .privacyPolicy; viewModel.toggleState() }
                        )

                        Divider()
                            .padding(.leading, 32)

                        CustomSettingsButton(
                            image: .settingsTermsOfUseIcon,
                            title: L10n.Settings.TermsOfUse.title,
                            action: { viewModel.state = .termsOfUse; viewModel.toggleState() }
                        )

                        Divider()
                            .padding(.leading, 32)

                        ShareLink(item: URL(string: viewModel.appStoreURL)!) {
                            HStack(spacing: 8) {
                                VStack {
                                    Image(.settingsShareThisAppIcon)
                                        .padding(8)
                                }
                                .background(Color.appPaleBlue)
                                .cornerRadius(12)
                                Text(L10n.Settings.ShareThisApp.title)
                                    .font(.appSemibold(of: 15))
                                    .foregroundStyle(Color.appMarengo)
                                Spacer()
                                Image(.settingsArrowIcon)
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.vertical, 16)
                }
                .sheet(isPresented: $viewModel.isShowing) {
                    switch viewModel.state {
                    case .contactUs:
                        MailView(isShowing: $viewModel.isShowing)
                    case .privacyPolicy:
                        if let privacyPolicyURL = URL(string: viewModel.privacyPolicyURL) {
                            WebView(url: privacyPolicyURL)
                        }
                    case .termsOfUse:
                        if let termsOfUseURL = URL(string: viewModel.termsOfUseURL) {
                            WebView(url: termsOfUseURL)
                        }
                    case .FAQ:
                        if let faqURL = URL(string: viewModel.faqURL) {
                            WebView(url: faqURL)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(24)
                .padding(.horizontal, 16)

                VStack {
                    VStack(spacing: 14) {
                        CustomSettingsButton(
                            image: .settingsFAQIcon,
                            title: L10n.Settings.Faq.title,
                            action: { viewModel.state = .FAQ; viewModel.toggleState() }
                        )

                        Divider()
                            .padding(.leading, 32)

                        CustomSettingsButton(
                            image: .settingsRateUsIcon,
                            title: L10n.Settings.RateUs.title,
                            action: { requestReview() }
                        )
                    }
                    .padding(.vertical, 16)
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(24)
                .padding(.horizontal, 16)
                Spacer()
            }
            .padding(.top, 70)

            CustomNavigationBar(
                scrollOffSet: $viewModel.scrollOffSet,
                navBarLayout: .leftButtonCenterTitle(
                    title: L10n.Settings.NavBar.title,
                    button: AnyView(CustomBackButton(showTabBar: $showTabBar))
                )
            )
        }
        .onAppear {
            showTabBar = false
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    SettingsView(showTabBar: .constant(true))
}
