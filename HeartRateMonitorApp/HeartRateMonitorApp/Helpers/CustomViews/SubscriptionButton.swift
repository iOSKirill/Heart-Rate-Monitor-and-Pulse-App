//
//  SubscriptionButtons.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 5.03.24.
//

import SwiftUI

struct SubscriptionButton: View {
    // MARK: - Property -
    @Binding var isOn: SubscriptionType
    var type: SubscriptionType
    var title: String
    var subtitle: String
    var cost: String
    var weekCost: String

    private let blueGradient = LinearGradient(
        gradient: Gradient(colors: [.appBlueGradientFirstButton, .appBlueGradientSecondButton]),
        startPoint: .top,
        endPoint: .bottom
    )

    // MARK: - Body -
    var body: some View {
        Button {
            isOn = type
        } label: {
            VStack {
                VStack {
                    VStack {
                        Text(title)
                            .font(.appUrbanistBold(of: isOn == type ? 12 : 10))
                            .foregroundColor(isOn == type ? .appMarengo : .white)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(10)
                    }
                    .background(isOn == type ? .white : .appBlue)
                    .cornerRadius(8)

                    VStack(spacing: 4) {
                        Text(subtitle)
                            .font(.appUrbanistBold(of: 16))
                            .foregroundColor(isOn == type ? .white : .appMarengo)
                        Text(weekCost)
                            .font(.appMedium(of: 12))
                            .foregroundColor(isOn == type ? .appBlueAlice : .appSlateGrey)
                    }
                    .padding(.top, 18)
                }
                .padding(.top, 9)

                Rectangle()
                    .frame(maxHeight: 1)
                    .foregroundColor(.black.opacity(0.15))
                    .padding(.top, 19)

                Text(cost)
                    .font(.appSemibold(of: 14))
                    .foregroundColor(isOn == type ? .white : .appMarengo)
                    .padding(.horizontal, 8)
                    .padding(.top, 6)
                    .padding(.bottom, 9)
            }
            .background(isOn == type ? AnyView(blueGradient) : AnyView(Color.white))
            .cornerRadius(14)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(isOn == type ? .clear : .appBlue, lineWidth: 2)
            )
        }
    }
}
