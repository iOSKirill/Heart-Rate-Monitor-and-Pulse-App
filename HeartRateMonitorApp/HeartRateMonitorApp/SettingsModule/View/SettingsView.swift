//
//  SettingsView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 4.12.23.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - Property -
    @StateObject var viewModel = SettingsViewModel()
    // MARK: - Body -
    var body: some View {
        ZStack {
            Color(.backgroundSreens).ignoresSafeArea()
            VStack {
                Text("Settings Screen")
            }
        }
    }
}

#Preview {
    SettingsView()
}
