//
//  SettingsView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 4.12.23.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - Property -
    @StateObject var viewModel = SettingsViewModel()
    @Environment(\.dismiss) var dismiss

    // MARK: - Back button -
    var backButton: some View {
        Button {
            dismiss()
        } label: {
            VStack {
                Image(.navBarBackButtonIcon)
                    .foregroundColor(Color.mainText)
                    .padding(10)
            }
            .background(Color.white)
            .cornerRadius(12)
        }
    }

    // MARK: - Body -
    var body: some View {
        ZStack(alignment: .top) {
            Color(.backgroundSreens).ignoresSafeArea()
            VStack(spacing: 12) {
                VStack {
                    VStack(spacing: 14) {
                        CustomSettingsButton(
                            image: .settingsContactUsIcon,
                            title: L10n.Settings.ContactUs.title
                        )
                        Divider()
                            .padding(.leading, 32)
                        CustomSettingsButton(
                            image: .settingsPrivacyPolicyIcon,
                            title: L10n.Settings.PrivacPolicy.title
                        )
                        Divider()
                            .padding(.leading, 32)
                        CustomSettingsButton(
                            image: .settingsTermsOfUseIcon,
                            title: L10n.Settings.TermsOfUse.title
                        )
                        Divider()
                            .padding(.leading, 32)
                        CustomSettingsButton(
                            image: .settingsShareThisAppIcon,
                            title: L10n.Settings.ShareThisApp.title
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
                            title: L10n.Settings.Faq.title
                        )
                        Divider()
                            .padding(.leading, 32)
                        CustomSettingsButton(
                            image: .settingsRateUsIcon,
                            title: L10n.Settings.RateUs.title
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
                    button: AnyView(backButton)
                )
            )
        }
    }
}

#Preview {
    SettingsView()
}
