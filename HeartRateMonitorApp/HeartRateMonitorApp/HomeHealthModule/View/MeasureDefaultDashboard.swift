//
//  MeasureDefaultDashboard.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 25.02.24.
//

import SwiftUI

struct MeasureDefaultDashboard: View {
    // MARK: - Property -
    @ObservedObject var viewModel: HomeHealthViewModel
    @Binding var isPopupVisible: Bool

    // MARK: - Body -
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(L10n.Dashboard.Measure.title)
                    .font(.appUrbanistBold(of: 17))
                    .foregroundColor(Color.white)
                Spacer()
              CustomButtonPopupPresented(isPopupVisible: $isPopupVisible)
            }
            .padding(.horizontal, 16)
            .padding(.top, 24)
            .padding(.bottom, 10)

            Rectangle()
                .frame(height: 1)
                .foregroundColor(.white.opacity(0.15))

            HStack(alignment: .center) {
                VStack(spacing: 13) {
                    Button {
                        viewModel.isPresentedMeasurementView.toggle()
                    } label: {
                        ZStack {
                            Circle()
                                .stroke(Color.white, lineWidth: 3)
                                .frame(width: 76, height: 76)
                            Image(.tapToStartButton)
                        }
                    }
                    .fullScreenCover(isPresented: $viewModel.isPresentedMeasurementView) {
                        MeasurementView()
                    }
                    Text(L10n.Button.Start.title)
                        .font(.appSemibold(of: 15))
                        .foregroundColor(.white)
                }
            }
            .padding(.top, 28)
            .frame(maxWidth: .infinity)

            HStack(alignment: .center) {
                VStack(spacing: 8) {
                    Text(L10n.Dashboard.Measure.subtitle)
                        .font(.appUrbanistBold(of: 19))
                        .foregroundColor(.white)
                    Text(L10n.Dashboard.Measure.mainText)
                        .font(.appSemibold(of: 15))
                        .foregroundColor(Color.appVeryLightBlue)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                    Image(.pulseLine)
                        .resizable()
                        .padding(.top, 14)
                        .padding(.bottom, 24)
                }
            }
            .padding(.top, 25)
            .frame(maxWidth: .infinity)
            Spacer()
        }
        .frame(maxWidth: .infinity, minHeight: 367)
        .background(
            ZStack {
                Color.appBlue
                Image(.measureBackgound)
                    .blur(radius: 8.5)
                    .opacity(0.8)
            }
        )
        .cornerRadius(20)
        .padding(.top, 70)
        .padding(.horizontal, 16)
    }
}
