//
//  HistoryDetailView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 31.01.24.
//

import SwiftUI

struct HistoryDetailView: View {
    // MARK: - Property -
    var historyInfo: PulseDB

    // MARK: - Body -
    var body: some View {
        VStack {
            HStack {
                Image(.historyHeadlineIcon)
                    .padding(.trailing, 12)
                Text(historyInfo.time.getDateOfHistory)
                    .font(.appUrbanistBold(of: 17))
                    .foregroundColor(.white)
                Spacer()
                Image(.historyArrowIcon)
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)

            Rectangle()
                .frame(height: 1)
                .foregroundColor(.white.opacity(0.15))

            HStack {

                // First section measurement
                VStack(spacing: 4) {
                    Text(L10n.History.Headline.pulse)
                        .font(.appSemibold(of: 15))
                        .foregroundColor(.white)

                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("\(historyInfo.pulse)")
                            .font(.appBlack(of: 32))
                            .foregroundColor(.white)
                        Text(L10n.History.bpm)
                            .font(.appMedium(of: 15))
                            .foregroundColor(.appVeryLightBlue)
                    }
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 8)

                Rectangle()
                    .frame(width: 1, height: 37)
                    .foregroundColor(.white.opacity(0.15))
                    .padding(.vertical, 20.5)

                // Second section measurement
                VStack(spacing: 4) {
                    Text(L10n.History.Headline.assessment)
                        .font(.appSemibold(of: 15))
                        .foregroundColor(.white)

                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("\(historyInfo.assessment)%")
                            .font(.appBlack(of: 32))
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 8)

                Rectangle()
                    .frame(width: 1, height: 37)
                    .foregroundColor(.white.opacity(0.15))
                    .padding(.vertical, 20.5)

                // Third section measurement
                VStack(spacing: 4) {
                    Text(L10n.History.Headline.hrv)
                        .font(.appSemibold(of: 15))
                        .foregroundColor(.white)

                    HStack(alignment: .firstTextBaseline, spacing: 4) {
                        Text("\(historyInfo.hrv)")
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
                    .opacity(0.8)
            }
        )
        .cornerRadius(20)
        .padding(.top, 12)
        .padding(.horizontal, 16)
        .buttonStyle(.plain)
    }
}
