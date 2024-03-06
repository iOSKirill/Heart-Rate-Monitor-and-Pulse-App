//
//  OnboardingView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 9.01.24.
//

import SwiftUI

struct OnboardingView: View {
    // MARK: - Property -
    @StateObject var viewModel = OnboardingViewModel()

    // MARK: - TabView onboarding -
    var tabView: some View {
        TabView(selection: $viewModel.currentStep) {
            ForEach(viewModel.onboardingSteps, id: \.id) { item in
                VStack(spacing: 8) {
                    Text(item.title)
                        .multilineTextAlignment(.center)
                        .font(.appUrbanistBold(of: 32))
                        .foregroundColor(Color.appMarengo)
                        .padding(.horizontal, 15)

                    Text(item.description)
                        .multilineTextAlignment(.center)
                        .font(.appMedium(of: 14))
                        .foregroundColor(Color.appSlateGrey)
                        .padding(.horizontal, 32)
                }
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .animation(.easeInOut(duration: 0.3), value: viewModel.currentStep)
    }

    var backgroundOnboardingStep: some View {
        TabView(selection: $viewModel.currentStep) {
            ForEach(viewModel.onboardingSteps, id: \.id) { item in
                if let image = item.image, item.id == 1 {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                } else {
                    if let image = item.image {
                        Image(image)
                            .resizable()
                            .frame(maxWidth: .infinity)
                            .aspectRatio(contentMode: .fit)
                    }
                }

            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .animation(.easeInOut(duration: 0.3), value: viewModel.currentStep)
    }

    // MARK: - PageControl onboarding -
    var pageControl: some View {
        HStack(spacing: 8) {
            ForEach(viewModel.onboardingSteps, id: \.id) { item in
                if item.id == viewModel.currentStep {
                    Rectangle()
                        .frame(width: 32, height: 8)
                        .cornerRadius(10)
                        .foregroundColor(Color.appBlue)
                } else {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color.appManatee)
                }
            }
        }
        .padding(.bottom, 18)
    }

    // MARK: - Next screen onboarding -
    var nextButton: some View {
        Button {
            viewModel.nextStepOnButton()
        } label: {
            Text(viewModel.getNextButtonText())
                .font(.appMedium(of: 16))
                .foregroundColor(.white)
                .padding(.vertical, 24)
                .padding(.horizontal, 95)
                .frame(maxWidth: .infinity)
                .background(viewModel.blueGradient)
                .cornerRadius(40)
                .padding(.horizontal, 16)
        }
        .padding(.bottom, 30)
    }

    var body: some View {
        ZStack(alignment: .top) {
            Image(viewModel.currentStep == 3 ? .paywallBackground : .onboardingBackground)
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()
            VStack {
                backgroundOnboardingStep
                    .offset(y: 30)
                Spacer()
                VStack {
                    tabView
                    pageControl
                    nextButton
                }
                .frame(maxWidth: .infinity, maxHeight: 312)
                .background(.white)
                .cornerRadius(20)
                if viewModel.currentStep == 3 {
                    TermsAndPrivacyButtons(
                        showWebView: $viewModel.showWebView,
                        webViewType: $viewModel.webViewType
                    )
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
