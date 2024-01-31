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

    // MARK: - Body -
    var body: some View {
        ZStack {
            Color(.appPaleBlue).ignoresSafeArea()
            CustomScrollView(scrollOffSet: $viewModel.scrollOffSet, navBarLayout: .leftTitleRightButton(
                title: L10n.History.NavBar.title,
                button: AnyView(CustomMainSettingsButton(isPresentedView: $viewModel.isPresentedSettingsView))
            )) {
                CustomHistoryView(
                    dateAndTimeMeasurement: "24.05.2023",
                    pulse: "80",
                    assessment: "65%",
                    hrv: "96"
                )
            }
        }
    }
}

#Preview {
    HistoryView()
}
