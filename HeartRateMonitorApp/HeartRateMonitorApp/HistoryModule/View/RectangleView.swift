//
//  RectangleView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 5.02.24.
//

import SwiftUI

struct RectangleView: View {
    // MARK: - Property -
    var gradientColor: Gradient

    // MARK: - Body -
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(maxWidth: .infinity)
            .frame(height: 130)
            .background(
                LinearGradient(
                gradient: gradientColor,
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 1)
                )
            )
            .cornerRadius(20)
            .padding(.horizontal, 16)
    }
}
