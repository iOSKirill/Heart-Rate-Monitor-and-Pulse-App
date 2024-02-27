//
//  MeasureNoDataDashboard.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 25.02.24.
//

import SwiftUI

struct MeasureNoDataDashboard: View {
    // MARK: - Property -
    @Binding var isPopupVisible: Bool

    // MARK: - Body -
    var body: some View {
        VStack {
            HStack {
                Text(L10n.Dashboard.Measure.title)
                    .font(.appUrbanistBold(of: 17))
                    .foregroundColor(.white)
                Spacer()
                PopupButton(isPopupVisible: $isPopupVisible)
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)

            Rectangle()
                .frame(height: 1)
                .foregroundColor(.white.opacity(0.15))
                .padding(.top, 10)

            VStack {
                Text(L10n.Dashboard.NoData.title)
                    .font(.appUrbanistBold(of: 19))
                    .foregroundColor(.white)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 72)

                Text(L10n.Dashboard.NoData.subtitle)
                    .font(.appSemibold(of: 15))
                    .foregroundColor(.appVeryLightBlue)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 72)

            Image(.pulseLine)
                .resizable()
                .padding(.top, 16)
                .padding(.bottom, 21)
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
