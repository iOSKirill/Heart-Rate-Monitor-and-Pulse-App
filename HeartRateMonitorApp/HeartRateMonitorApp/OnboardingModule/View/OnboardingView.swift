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
                        .foregroundColor(Color.mainText)
                        .padding(.horizontal, 15)
                    
                    Text(item.description)
                        .multilineTextAlignment(.center)
                        .font(.appMedium(of: 14))
                        .foregroundColor(Color.subtitle)
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
                if item.id == 1 {
                    Image(item.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                } else {
                    Image(item.image)
                        .resizable()
                        .frame(maxWidth: .infinity)
                        .aspectRatio(contentMode: .fit)
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
                        .foregroundColor(Color.currentDay)
                } else {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundColor(Color.notHighlightedButton)
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
            Image(.onboardingBackground)
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
            }
        }
    }
}

#Preview {
    OnboardingView()
}
