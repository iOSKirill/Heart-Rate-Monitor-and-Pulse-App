//
//  SubscriptionView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 5.03.24.
//

import SwiftUI

struct SubscriptionView: View {
    // MARK: - Property -
    @StateObject var viewModel = SubscriptionViewModel()

    // MARK: - Subscription buttons -
    var subscriptionButtons: some View {
        HStack(spacing: 10) {
            SubscriptionButton(
                isOn: $viewModel.selectedSubscription,
                type: .monthly,
                title: L10n.Subscription.Monthly.title,
                subtitle: L10n.Subscription.Monthly.subtitle,
                cost: L10n.Subscription.Monthly.Cost.title,
                weekCost: L10n.Subscription.Monthly.Cost.subtitle
            )

            SubscriptionButton(
                isOn: $viewModel.selectedSubscription,
                type: .weekly,
                title: L10n.Subscription.Weekly.title,
                subtitle: L10n.Subscription.Weekly.subtitle,
                cost: L10n.Subscription.Weekly.Cost.title,
                weekCost: L10n.Subscription.Weekly.Cost.subtitle
            )

            SubscriptionButton(
                isOn: $viewModel.selectedSubscription,
                type: .yearly,
                title: L10n.Subscription.Yearly.title,
                subtitle: L10n.Subscription.Yearly.subtitle,
                cost: L10n.Subscription.Yearly.Cost.title,
                weekCost: L10n.Subscription.Yearly.Cost.subtitle
            )
        }
        .padding(.top, 12)
        .padding(.horizontal, 25)
    }

    // MARK: - Confirm subscription button -
    var confirmSubscriptionButton: some View {
        Button {

        } label: {
            Text(L10n.Subscription.button)
                .font(.appMedium(of: 14))
                .foregroundColor(.white)
                .foregroundColor(.white)
                .padding(.vertical, 25)
                .padding(.horizontal, 87)
                .frame(maxWidth: .infinity)
                .background(viewModel.blueGradient)
                .cornerRadius(40)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
        }
    }

    // MARK: - Subscription plan selection view -
    var subscriptionPlanSelection: some View {
        VStack {
            VStack(spacing: 3) {
                Text(L10n.Subscription.title)
                    .font(.appUrbanistBold(of: 32))
                    .foregroundColor(.appMarengo)
                    .multilineTextAlignment(.center)

                Text(L10n.Subscription.subtitle)
                    .font(.appMedium(of: 14))
                    .foregroundColor(.appSlateGrey)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 18)

            subscriptionButtons
            confirmSubscriptionButton
            TermsAndPrivacyButtons(
                showWebView: $viewModel.showWebView,
                webViewType: $viewModel.webViewType
            )
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(20)
    }

    // MARK: - Body -
    var body: some View {
        ZStack(alignment: .top) {
            Image(.paywallBackground)
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
            VStack {
                Spacer()
                subscriptionPlanSelection
            }
        }
    }
}

#Preview {
    SubscriptionView()
}
