//
//  CustomHistoryView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 31.01.24.
//

import SwiftUI

struct CustomHistoryView: View {
    // MARK: - Property -
    var dateAndTimeMeasurement: String
    var pulse: String
    var assessment: String
    var hrv: String

    // MARK: - Body -
    var body: some View {
        VStack {
            HStack {
                Image(.historyHeadlineIcon)
                    .padding(.trailing, 12)
                Text(dateAndTimeMeasurement)
                    .font(.appUrbanistBold(of: 17))
                    .foregroundColor(.white)
                Spacer()
                Image(.historyArrowIcon)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)

            Divider()
                .frame(maxWidth: .infinity, maxHeight: 1)
                .background(Color.white.opacity(0.2))

            HStack {

                // First section measurement
                VStack(spacing: 4) {
                    Text(L10n.History.Headline.pulse)
                        .font(.appSemibold(of: 15))
                        .foregroundColor(.white)

                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text(pulse)
                            .font(.appBlack(of: 32))
                            .foregroundColor(.white)
                        Text(L10n.History.bpm)
                            .font(.appMedium(of: 15))
                            .foregroundColor(.appVeryLightBlue)
                    }
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 8)

                Divider()
                    .frame(maxWidth: 1)
                    .background(Color.white.opacity(0.2))
                    .padding(.vertical, 20.5)

                // Second section measurement
                VStack(spacing: 4) {
                    Text(L10n.History.Headline.assessment)
                        .font(.appSemibold(of: 15))
                        .foregroundColor(.white)

                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text(assessment)
                            .font(.appBlack(of: 32))
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 8)

                Divider()
                    .frame(maxWidth: 1)
                    .background(Color.white.opacity(0.2))
                    .padding(.vertical, 20.5)

                // Third section measurement
                VStack(spacing: 4) {
                    Text(L10n.History.Headline.hrv)
                        .font(.appSemibold(of: 15))
                        .foregroundColor(.white)

                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text(hrv)
                            .font(.appBlack(of: 32))
                            .foregroundColor(.white)
                        Text(L10n.History.ms)
                            .font(.appMedium(of: 15))
                            .foregroundColor(.appVeryLightBlue)
                    }
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 8)
            }
            .padding(.top, 16)
            .padding(.bottom, 19)

            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
            Color.appBlue
            Image(.historyBackground)
                    .blur(radius: 8.5)
                    .opacity(0.6)
            }
        )
        .cornerRadius(20)
        .padding(.top, 12)
        .padding(.horizontal, 16)
    }
}
