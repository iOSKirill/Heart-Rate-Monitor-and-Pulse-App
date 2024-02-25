//
//  MeasureDetailsDashboard.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 25.02.24.
//

import SwiftUI

struct MeasureDetailsDashboard: View {
    // MARK: - Property -
    @ObservedObject var viewModel: HomeHealthViewModel
    @Binding var isPopupVisible: Bool

    // MARK: - Body -
    var body: some View {
        VStack {
            HStack {
                Text("\(viewModel.dailyAverage.time?.getDateHomeDeatails ?? "")")
                    .font(.appUrbanistBold(of: 17))
                    .foregroundColor(.white)
                Spacer()
                CustomButtonPopupPresented(isPopupVisible: $isPopupVisible)
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)

            Rectangle()
                .frame(height: 1)
                .foregroundColor(.white.opacity(0.15))
                .padding(.top, 10)

            HStack {
                // Assessment detail
                VStack(spacing: 0) {
                    HStack(spacing: 10) {
                        Image(.historyAssessmentIcon)
                        Text(L10n.History.Headline.assessment)
                            .font(.appUrbanistBold(of: 19))
                            .foregroundColor(.white)
                    }

                    Text("\(viewModel.dailyAverage.assessment ?? 0)%")
                        .font(.appBlack(of: 48))
                        .foregroundColor(.white)
                        .padding(.leading, 42)
                        .padding(.trailing, 16)
                }

                Rectangle()
                    .frame(width: 1, height: 134)
                    .foregroundColor(.white.opacity(0.15))
                    .padding(.horizontal, 4)

                VStack(alignment: .leading, spacing: 8) {
                    // Pulse detail
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 8) {
                            Image(.historyPulseIcon)
                            Text(L10n.History.Headline.pulse)
                                .font(.appUrbanistBold(of: 15))
                                .foregroundColor(.white)
                        }

                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Text("\(viewModel.dailyAverage.pulse ?? 0)")
                                .font(.appBlack(of: 32))
                                .foregroundColor(.white)
                            Text(L10n.History.bpm)
                                .font(.appMedium(of: 15))
                                .foregroundColor(.appLightBlue)
                        }
                        .padding(.leading, 32)
                    }

                    // HRV detail
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 8) {
                            Image(.historyHRVIcon)
                            Text(L10n.History.Headline.hrv)
                                .font(.appUrbanistBold(of: 15))
                                .foregroundColor(.white)
                        }

                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Text("\(viewModel.dailyAverage.hrv ?? 0)")
                                .font(.appBlack(of: 32))
                                .foregroundColor(.white)
                            Text(L10n.History.ms)
                                .font(.appMedium(of: 15))
                                .foregroundColor(.appLightBlue)
                        }
                        .padding(.leading, 32)
                    }
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .padding(.top, 24)
            .padding(.bottom, 15)

            Text(viewModel.getDescriptionForAssessment())
                .font(.appSemibold(of: 15))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            Image(.pulseLine)
                .resizable()
                .padding(.top, 20)
                .padding(.bottom, 22)

        }
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                Color.appBlue
                Image(.measureBackgound)
                    .blur(radius: 8.5)
                    .opacity(0.8)
            }
        )
        .cornerRadius(20)
        .padding(.horizontal, 16)
        .padding(.top, 70)
    }
}
