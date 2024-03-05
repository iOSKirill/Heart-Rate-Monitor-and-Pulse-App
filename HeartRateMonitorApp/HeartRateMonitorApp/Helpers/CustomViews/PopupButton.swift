//
//  PopupButtonPresented.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 25.02.24.
//

import SwiftUI

struct PopupButton: View {
    // MARK: - Property -
    @Binding var isPopupVisible: Bool

    // MARK: - Body -
    var body: some View {
        Button {
            withAnimation(.linear(duration: 0.3)) {
                isPopupVisible.toggle()
            }
        } label: {
            Image(.informationButton)
        }
    }
}
