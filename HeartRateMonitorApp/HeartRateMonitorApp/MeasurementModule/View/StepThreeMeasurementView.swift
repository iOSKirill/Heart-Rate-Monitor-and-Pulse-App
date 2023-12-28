//
//  StepThreeMeasurementView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 27.12.23.
//

import SwiftUI

struct StepThreeMeasurementView: View {
    // MARK: - Property -
    @StateObject var viewModel = MeasurementViewModel()

    // MARK: - Body -
    var body: some View {
        Text(L10n.Measurement.StepThree.title)
            .font(.appSemibold(of: 15))
            .foregroundColor(Color.subtitle)
            .multilineTextAlignment(.center)

        ProgressBar(
            isProgressBar: viewModel.isProgressBar,
            isBeatingHeart: viewModel.isBeatingHeart,
            pulse: viewModel.pulseValue
        )

        VStack(spacing: 16) {
            Button {
                // Save measurement
            } label: {
                VStack {
                    Text(L10n.Measurement.StepThree.Button.save)
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

            Button {
                // Not now
            } label: {
                Text(L10n.Measurement.StepThree.Button.notNow)
                    .font(.appUrbanistBold(of: 15))
                    .foregroundColor(Color.subtitle)
            }
        }
    }
}
