//
//  StepOneMeasurementView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 27.12.23.
//

import SwiftUI

#warning("TODO: remove me")
@available(*, deprecated)
struct StepOneMeasurementView: View {
    // MARK: - Property -
    @StateObject var viewModel = MeasurementViewModel()
    @Binding var currentStepMeasurement: StepMeasurement

    // MARK: - Body -
    var body: some View {
        Text(L10n.Measurement.StepOne.title)
            .font(.appSemibold(of: 15))
            .foregroundColor(Color.subtitle)
            .multilineTextAlignment(.center)

        ProgressBar(
            progress: viewModel.isProgressBar,
            isHeartBeating: viewModel.isBeatingHeart,
            pulse: viewModel.pulseValue
        )

        viewModel.stepOneSubtitle

        Button {
            currentStepMeasurement = .second
        } label: {
            VStack {
                Text(L10n.Measurement.StepOne.button)
                    .font(.appUrbanistBold(of: 15))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: 37)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.blueGradientFirstButton,
                        Color.blueGradientSecondButton
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .cornerRadius(43)
            .padding(.horizontal, 101.5)
            .shadow(color: Color.shadowButton.opacity(0.15), radius: 5.95, x: 0, y: 4)
        }
    }
}
