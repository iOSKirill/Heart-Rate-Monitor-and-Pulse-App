//
//  CustomMainSettingsButton.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 31.01.24.
//

import SwiftUI

struct CustomMainSettingsButton: View {
    @Binding var showTabBar: Bool
    // MARK: - Body -
    var body: some View {
        NavigationLink {
            SettingsView(showTabBar: $showTabBar)
        } label: {
            VStack {
                Image(.settingsButton)
                    .padding(8)
            }
            .background(.white)
            .cornerRadius(12)
        }
    }
}
