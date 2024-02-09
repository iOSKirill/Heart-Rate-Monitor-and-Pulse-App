//
//  HistoryView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 29.11.23.
//

import SwiftUI

struct HistoryView: View {
    // MARK: - Property -
    @StateObject var viewModel = HistoryViewModel()
    @Binding var showTabBar: Bool

    var notDataMeasurement: some View {
        VStack(spacing: 8) {
            VStack {
                HStack(spacing: 12) {
                    Image(.assessmentIcon)
                    Text(L10n.History.Headline.noData)
                        .font(.appUrbanistBold(of: 17))
                        .foregroundColor(.appMarengo)
                    Spacer()
                }
                .padding(.top, 16)
                .padding(.horizontal, 16)

                VStack(spacing: 2) {
                    Text(L10n.History.NoData.title)
                        .font(.appUrbanistBold(of: 19))
                        .foregroundColor(.appMarengo)
                    Text(L10n.History.NoData.subtitle)
                        .font(.appSemibold(of: 15))
                        .foregroundColor(.appSlateGrey)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 26)
                .padding(.bottom, 38)
            }
            .frame(maxWidth: .infinity)
            .background(
                ZStack {
                Color.appBlue
                Image(.historyNoDataBackground)
                        .blur(radius: 8.5)
                        .opacity(0.9)
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.white.opacity(0.7),
                            Color.white.opacity(0.4)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
            )
            .cornerRadius(20)
            .padding(.top, 12)
            .padding(.horizontal, 16)

            RectangleView(gradientColor: viewModel.rectangleGradientFirst)
            RectangleView(gradientColor: viewModel.rectangleGradientSecond)
        }
    }

    // MARK: - Body -
    var body: some View {
        NavigationView {
            ZStack {
                Color(.appPaleBlue).ignoresSafeArea()
                CustomScrollView(scrollOffSet: $viewModel.scrollOffSet, navBarLayout: .leftTitleRightButton(
                    title: L10n.History.NavBar.title,
                    button: AnyView(CustomMainSettingsButton(isPresentedView: $viewModel.isPresentedSettingsView))
                )) {
                    VStack {
                        if !viewModel.arrayPulseDB.isEmpty {
                            ForEach(viewModel.arrayPulseDB, id: \.self) { item in
                                NavigationLink(destination: HistoryInfoView(
                                    viewModel: HistoryInfoViewModel(measurementDetails: item),
                                    showTabBar: $showTabBar
                                )) {
                                    CustomHistoryView(historyInfo: item)
                                }
                            }
                        } else {
                            notDataMeasurement
                        }
                    }
                    .onAppear {
                        viewModel.trackingChangesRealmDB()
                        let dr = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                        print(dr)
                    }
                }
            }
        }
    }
}

#Preview {
    HistoryView(showTabBar: .constant(true))
}
