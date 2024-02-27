//
//  TodayWeekToggleView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 18.02.24.
//

import SwiftUI

struct TodayWeekToggleView: View {
    // MARK: - Property -
    @Binding var isOn: Bool
    let blueGradient = LinearGradient(
        gradient: Gradient(colors: [.appBlueGradientFirstButton, .appBlueGradientSecondButton]),
        startPoint: .top,
        endPoint: .bottom
    )

    // MARK: - Body -
    var body: some View {
        HStack(spacing: 1) {
            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isOn.toggle()
                }
            } label: {
                VStack {
                    Text(L10n.Dashboard.Statistics.Button.today)
                        .font(.appUrbanistBold(of: 13))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                }
                .foregroundColor(isOn ? .white : .appMarengo)
                .background(isOn ? AnyView(blueGradient) : AnyView(Color.appPaleBlue))
                .cornerRadius(50)
            }
            .padding(.vertical, 2)
            .padding(.leading, 2)

            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isOn.toggle()
                }
            } label: {
                Text(L10n.Dashboard.Statistics.Button.week)
                    .font(.appUrbanistBold(of: 13))
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
            }
            .foregroundColor(isOn ? .appMarengo : .white)
            .background(isOn ? AnyView(Color.appPaleBlue) : AnyView(blueGradient))
            .cornerRadius(50)
            .padding(.vertical, 2)
            .padding(.trailing, 2)
        }
        .background(.appPaleBlue)
        .cornerRadius(58)
    }
}
