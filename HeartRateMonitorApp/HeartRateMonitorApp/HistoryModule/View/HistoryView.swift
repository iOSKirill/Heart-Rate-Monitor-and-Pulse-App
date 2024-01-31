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
                ForEach(viewModel.arrayPulseDB, id: \.self) { item in
                    CustomHistoryView(
                        dateAndTimeMeasurement: item.time.getdateOfHistory,
                        pulse: item.value,
                        assessment: "65%",
                        hrv: "96"
                    )
                }
                .onAppear {
                    viewModel.trackingChangesRealmDB()
                }
            }
        }

    }
}

#Preview {
    HistoryView()
}
