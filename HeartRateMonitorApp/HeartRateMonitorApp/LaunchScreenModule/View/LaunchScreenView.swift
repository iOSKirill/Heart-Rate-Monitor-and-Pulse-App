//
//  LaunchScreenView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 9.01.24.
//

import SwiftUI

enum AppCondition: String {
    case onboardingView
    case homeHealthView
}

struct LaunchScreenView: View {
    // MARK: - Property -
    @StateObject var viewModel = LaunchScreenViewModel()

    // MARK: - Body -
    var body: some View {
        ZStack {
            viewModel.blueGradient.ignoresSafeArea()
            Image(.appIconLaunchScreen)
        }
        .fullScreenCover(isPresented: $viewModel.isPresentedNextScreen) {
            switch viewModel.appCondition {
            case .onboardingView:
                OnboardingView()

            case .homeHealthView:
                TabBarView()

            case .none:
                OnboardingView()
            }
        }
        .task {
            viewModel.nextPresentedView()
        }
    }
}

#Preview {
    LaunchScreenView()
}
