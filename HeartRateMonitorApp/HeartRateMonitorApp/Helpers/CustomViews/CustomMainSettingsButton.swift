//
//  CustomMainSettingsButton.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 31.01.24.
//

import SwiftUI

struct CustomMainSettingsButton: View {
    // MARK: - Property -
    @Binding var isPresentedView: Bool

    // MARK: - Body -
    var body: some View {
        Button {
            isPresentedView.toggle()
        } label: {
            VStack {
                Image(.settingsButton)
                    .padding(8)
            }
            .background(.white)
            .cornerRadius(12)
        }
        .fullScreenCover(isPresented: $isPresentedView) {
            SettingsView()
        }
    }
}
