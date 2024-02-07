//
//  HistoryInfoView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 6.02.24.
//

import SwiftUI

struct HistoryInfoView: View {
    // MARK: - Property -
    @State var scrollOffSet: CGFloat = 0.0
    @State var isPresentedSettingsView: Bool = false
    @State var measurementDetails: PulseDB
    @Binding var showTabBar: Bool

    // MARK: - Share button -
    var shareHistoryButton: some View {
        Button {
           // Share history
        } label: {
            VStack {
                Image(.historyShareIcon)
                    .foregroundColor(Color.appMarengo)
                    .padding(10)
            }
            .background(Color.white)
            .cornerRadius(12)
        }
    }

    var measurementDetailsView: some View {
        VStack {

            // Headline
            HStack {
                Text(measurementDetails.time.getDateOfHistoryDetails)
                    .font(.appUrbanistBold(of: 17))
                    .foregroundColor(.white)
                Spacer()
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

                    Text(measurementDetails.assessment)
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
                            Text(measurementDetails.pulse)
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
                            Text(measurementDetails.hrv)
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

            Text("Today your body is working quite \n well and is ready to work.")
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
        .padding(.top, 12)
    }

    var intoAboutMeasurementView: some View {
        VStack {
            VStack(spacing: 12) {
                CustomPopupVStackInfo(
                    image: .popupAssessmentIcon,
                    title: L10n.Popup.Assessment.title,
                    subtitle: L10n.Popup.Assessment.subtitle
                )
                CustomPopupVStackInfo(
                    image: .popupPulseIcon,
                    title: L10n.Popup.Pulse.title,
                    subtitle: L10n.Popup.Pulse.subtitle
                )
                CustomPopupVStackInfo(
                    image: .popupHRVIcon,
                    title: L10n.Popup.Hrv.title,
                    subtitle: L10n.Popup.Hrv.subtitle
                )
            }
            .padding(.vertical, 20)
         }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal, 16)
        .padding(.bottom, 30)
    }

    // MARK: - Body -
    var body: some View {
        ZStack {
            Color(.appPaleBlue).ignoresSafeArea()
            CustomScrollView(scrollOffSet: $scrollOffSet, navBarLayout: .leftButtonCenterTitleRightButton(
                title: L10n.History.NavBar.title,
                buttonFirst: AnyView(CustomBackButton(showTabBar: $showTabBar)),
                buttonSecond: AnyView(shareHistoryButton)
            )) {
                VStack(spacing: 11) {
                    measurementDetailsView
                    intoAboutMeasurementView
                }
            }
        }
        .onAppear {
            showTabBar = false
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    HistoryInfoView(measurementDetails: .init(pulse: "60", hrv: "90", assessment: "50%", time: .now), showTabBar: .constant(true))
}
