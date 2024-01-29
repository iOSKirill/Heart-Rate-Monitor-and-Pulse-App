//
//  MeasurementContentView.swift
//  HeartRateMonitorApp
//
//  Created by Veranika Shakh on 21/01/2024.
//

import SwiftUI

struct MeasurementContentView: View {
    // MARK: - Property -
    var title: String
    var progress: Float
    var isHeartBeating: Bool
    var pulse: String
    var descriptionText: Text?
    var buttonGradient: Gradient
    var buttonTitle: String
    var action: () -> Void
    var notNowButtonTitle: String?
    @State private var isPresentedHomeHealthView = false

    // MARK: - Body -
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text(title)
                .font(.appSemibold(of: 15))
                .foregroundColor(Color.appSlateGrey)
                .multilineTextAlignment(.center)

            ProgressBarView(
                progress: progress,
                isHeartBeating: isHeartBeating,
                pulse: pulse
            )

            if let descriptionText {
                descriptionText

            }

            Button {
                action()
            } label: {
                VStack {
                    Text(buttonTitle)
                        .font(.appUrbanistBold(of: 15))
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 54)
                }
                .background(
                    LinearGradient(
                        gradient: buttonGradient,
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .cornerRadius(43)
                .shadow(color: Color.appBlueShadow.opacity(0.15), radius: 5.95, x: 0, y: 4)
            }

            if let notNowButtonTitle {
                Button {
                    isPresentedHomeHealthView.toggle()
                } label: {
                    Text(notNowButtonTitle)
                        .font(.appUrbanistBold(of: 15))
                        .foregroundColor(Color.appSlateGrey)
                }
                .fullScreenCover(isPresented: $isPresentedHomeHealthView) {
                    TabBarView()
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 32)
    }
}

#Preview {
    MeasurementContentView(
        title: "Start",
        progress: 0.1,
        isHeartBeating: true,
        pulse: "50",
        descriptionText: Text("initial view"),
        buttonGradient: Gradient(colors: [
            .appBlueGradientFirstButton,
            .appBlueGradientSecondButton
        ]),
        buttonTitle: "Start",
        action: { print("initial action") }
    )
}
