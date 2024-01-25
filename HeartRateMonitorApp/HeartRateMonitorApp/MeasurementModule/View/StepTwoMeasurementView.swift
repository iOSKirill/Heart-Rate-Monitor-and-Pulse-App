//
//  StepTwoMeasurementView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 27.12.23.
//

import SwiftUI

#warning("TODO: remove me")
@available(*, deprecated)
struct StepTwoMeasurementView: View {
    // MARK: - Property -
    @StateObject var viewModel = MeasurementViewModel()
    @Binding var currentStepMeasurement: StepMeasurement

    // MARK: - Body -
    var body: some View {
        Text(L10n.Measurement.StepTwo.title)
            .font(.appSemibold(of: 15))
            .foregroundColor(Color.appSlateGrey)
            .multilineTextAlignment(.center)

        ProgressBar(
            progress: viewModel.isProgressBar,
            isHeartBeating: viewModel.isBeatingHeart,
            pulse: viewModel.pulseValue
        )

        viewModel.measurementTime

        Button {
            currentStepMeasurement = .first
        } label: {
            VStack {
                Text(L10n.Measurement.StepTwo.button)
                    .font(.appUrbanistBold(of: 15))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: 37)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.appRedGradientFirstButton,
                        Color.appRedGradientSecondButton
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .cornerRadius(43)
            .padding(.horizontal, 101.5)
        }
        .onAppear {
//            viewModel.initVideoCapture()
//            viewModel.initCaptureSession()
        }
        .onDisappear {
//            viewModel.deinitCaptureSession()
        }
    }
}
