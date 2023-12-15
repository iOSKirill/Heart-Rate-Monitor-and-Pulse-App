//
//  CustomNavigationBar.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 12.12.23.
//

import SwiftUI

struct ScrollPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct CustomNavigationBar: View {
    // MARK: - Property -
    @StateObject var viewModel = HomeHealthViewModel()
    @Binding var isScrolling: Bool
    @State private var isPresentedSettingsView = false

    // MARK: - Body -
    var body: some View {
        ZStack {
            Color.clear
                .frame(height: 110)
                .background(.ultraThinMaterial)
                .opacity(isScrolling ? 1 : 0)
                .blur(radius: 0.5)
                .edgesIgnoringSafeArea(.top)
            HStack {
                Text(L10n.NavigationBar.Health.title)
                    .font(.appUrbanistBold(of: 32))
                    .foregroundStyle(.mainText)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Button {
                    isPresentedSettingsView.toggle()
                } label: {
                    VStack {
                        Image(.settingsButton)
                            .padding(8)
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .padding(.top, 16)
                    .padding(.bottom, 20)
                }
                .fullScreenCover(isPresented: $isPresentedSettingsView) {
                    SettingsView()
                }
            }
            .offset(y: -35)
            .padding(.horizontal)
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
}
