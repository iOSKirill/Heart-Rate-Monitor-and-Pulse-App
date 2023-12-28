//
//  StepTwoMeasurementView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 27.12.23.
//

import SwiftUI

struct StepTwoMeasurementView: View {
    // MARK: - Property -
    @StateObject var viewModel = MeasurementViewModel()
    @Binding var currentStepMeasurement: StepMeasurement

    // MARK: - Body -
    var body: some View {
        Text(L10n.Measurement.StepTwo.title)
            .font(.appSemibold(of: 15))
            .foregroundColor(Color.subtitle)
            .multilineTextAlignment(.center)

        ProgressBar(
            isProgressBar: viewModel.isProgressBar,
            isBeatingHeart: viewModel.isBeatingHeart,
            pulse: viewModel.lastPulseValue
        )

        Text(L10n.Measurement.StepTwo.subtitle)
            .font(.appSemibold(of: 15))
            .foregroundColor(Color.subtitle)

        Button {
            currentStepMeasurement = .third
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
                        Color.redGradientFirstButton,
                        Color.redGradientSecondButton
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .cornerRadius(43)
            .padding(.horizontal, 101.5)
        }
        .onAppear {
            viewModel.initVideoCapture()
            viewModel.initCaptureSession()
        }
        .onDisappear {
            viewModel.deinitCaptureSession()
        }
    }
}
