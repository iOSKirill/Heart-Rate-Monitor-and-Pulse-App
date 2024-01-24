//
//  MeasurementView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 15.12.23.
//

import SwiftUI

struct InfoView: View {
    // MARK: - Body -
    var body: some View {
        VStack {
            Image(.measurementiPhone)
                .resizable()
                .scaledToFit()
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(24)
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
    }
}

struct AssessmentView: View {
    // MARK: - Body -
    var body: some View {
        VStack(spacing: 4) {
            Text(L10n.Measurement.StepThree.Assessment.title)
                .font(.appUrbanistBold(of: 17))
                .foregroundColor(Color.mainText)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
                .padding(.top, 26)
            Image(.measurementAssessmentBackground)
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 16)
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(24)
        .padding(.horizontal, 16)
    }
}

struct MeasurementView: View {
    // MARK: - Property -
    @StateObject var viewModel = MeasurementViewModel()
    @State var currentPulse: String = ""
    @Environment(\.dismiss) var dismiss

    // MARK: - Close view button -
     var closeViewButton: some View {
         Button {
             dismiss()
         } label: {
             VStack {
                 Image(.navBarCloseButtonIcon)
                     .foregroundColor(Color.mainText)
                     .padding(8)
             }
             .background(.white.opacity(0.6))
             .cornerRadius(12)
         }
     }

    // MARK: - Measurement view -
    var measurementView: some View {
        VStack {
            VStack(alignment: .center, spacing: 20) {
                MeasurementContentView(
                    title: viewModel.title,
                    progress: viewModel.progress,
                    isHeartBeating: viewModel.isBeatingHeart,
                    pulse: viewModel.pulseValue,
                    descriptionText: viewModel.stepOneSubtitle,
                    buttonGradient: viewModel.buttonGradient,
                    buttonTitle: viewModel.buttonTitle,
                    action: { viewModel.toggleState() }
                )
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: 379)
        .background(.white)
        .cornerRadius(24)
        .padding(.horizontal, 16)
    }

    // MARK: - Body -
    var body: some View {
        ZStack {
            Color(.backgroundSreens).ignoresSafeArea()
            CustomScrollView(scrollOffSet: $viewModel.scrollOffSet,
                             navBarLayout: .centerTitleRightButton(
                title: L10n.Measurement.NavBar.title,
                button: AnyView(closeViewButton)
            )) {
                VStack {
                    measurementView
                    switch viewModel.currentStepMeasurement {
                    case .first:
                        InfoView()
                    case .second:
                        InfoView()
                    case .third:
                        AssessmentView()
                    }
                }
                .padding(.top, 23)
            }
        }
    }
}

#Preview {
    MeasurementView()
}
