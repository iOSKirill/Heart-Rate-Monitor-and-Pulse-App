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
                        .disabled(!MFMailComposeViewController.canSendMail())
                        .sheet(isPresented: $viewModel.isShowingMailView) {
                            MailView(isShowing: $viewModel.isShowingMailView)
                        }

                        Divider()
                            .padding(.leading, 32)

                        CustomSettingsButton(
                            image: .settingsPrivacyPolicyIcon,
                            title: L10n.Settings.PrivacPolicy.title,
                            action: { viewModel.state = .privacyPolicy; viewModel.toggleState() }
                        )
                        .sheet(isPresented: $viewModel.isShowingPrivacyPolicy) {
                            if let privacyPolicyURL = URL(string: viewModel.privacyPolicyURL) {
                                WebView(url: privacyPolicyURL)
                            }
                        }

                        Divider()
                            .padding(.leading, 32)

                        CustomSettingsButton(
                            image: .settingsTermsOfUseIcon,
                            title: L10n.Settings.TermsOfUse.title,
                            action: { viewModel.state = .termsOfUse; viewModel.toggleState() }
                        )
                        .sheet(isPresented: $viewModel.isShowingTermsOfUse) {
                            if let termsOfUseURL = URL(string: viewModel.termsOfUseURL) {
                                WebView(url: termsOfUseURL)
                            }
                        }

                        Divider()
                            .padding(.leading, 32)

                        CustomSettingsButton(
                            image: .settingsShareThisAppIcon,
                            title: L10n.Settings.ShareThisApp.title,
                            action: { viewModel.state = .shareApp; viewModel.toggleState()  }
                        )
                    }
                    .padding(.vertical, 16)
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
                        .sheet(isPresented: $viewModel.isShowingFAQ) {
                            if let faqURL = URL(string: viewModel.faqURL) {
                                WebView(url: faqURL)
                            }
                        }

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
