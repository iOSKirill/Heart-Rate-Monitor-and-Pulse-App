//
//  ProgressBarView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 27.12.23.
//

import SwiftUI

struct ProgressBarView: View {
    // MARK: - Property -
    var progress: Float
    var isHeartBeating: Bool
    var pulse: String

    // MARK: - Body -
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.appPaleBlue, lineWidth: 10)
                .foregroundColor(.gray)
                .frame(width: 159, height: 159)

            Circle()
                .trim(from: 0.0, to: CGFloat(self.progress))
                .stroke(style: StrokeStyle(lineWidth: 12.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.appRed)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear(duration: 1.0), value: progress)
                .shadow(color: .appRed, radius: 1.5)

            HStack {
                Text(pulse)
                    .font(.appUrbanistBold(of: 58))
                    .foregroundColor(pulse != "00" ? Color.appMarengo : Color.appPaleBlue)

                VStack {
                    Image(.measureHeart)
                        .scaleEffect(isHeartBeating ? 0.5 : 1)
                        .animation(
                            .easeInOut(duration: 0.6)
                            .repeatForever(autoreverses: true),
                            value: isHeartBeating
                        )
                        .shadow(color: .appRed, radius: 5)

                    Text(L10n.Measurement.bpm)
                        .font(.appMedium(of: 15))
                        .foregroundColor(Color.appSlateGrey)
                        .offset(y: -9)
                }
            }
        }
    }
}
