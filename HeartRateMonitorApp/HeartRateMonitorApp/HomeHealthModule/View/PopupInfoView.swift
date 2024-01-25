//
//  PopupInfoView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 13.12.23.
//

import SwiftUI

struct PopupInfoView: View {
    // MARK: - Property -
    @Binding var isPopupVisible: Bool

    // MARK: - Body-
    var body: some View {
        VStack(alignment: .leading) {
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
                Button {
                    withAnimation(.linear(duration: 0.3)) {
                        isPopupVisible.toggle()
                    }
                } label: {
                    VStack {
                        Text(L10n.Popup.Button.title)
                            .font(.appUrbanistBold(of: 15))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 37)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.appBlueGradientFirstButton,
                                Color.appBlueGradientSecondButton
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .cornerRadius(43)
                    .padding(.horizontal, 101.5)
                    .shadow(color: Color.appBlueShadow.opacity(0.15), radius: 5.95, x: 0, y: 4)
                }
            }
            .padding(.vertical, 20)
        }
        .frame(maxWidth: .infinity, minHeight: 363)
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal, 16)
        .transition(.scale)
    }
}
