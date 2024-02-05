//
//  TabBarView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 29.11.23.
//

import SwiftUI

struct TabBarView: View {
    // MARK: - Property -
    @State private var selectedIndex: Int = 0
    @State private var isPopupVisible = false
    @State private var isPresentedMeasurementView = false

    // MARK: - Plus button  -
    var plusBarButton: some View {
        Button {
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            isPresentedMeasurementView.toggle()
        } label: {
            Image(.plusButton)
        }
        .overlay(
            Circle()
                .stroke(Color.white, lineWidth: 5)
        )
        .background(Color.white)
        .clipShape(Circle())
        .offset(y: -10)
        .fullScreenCover(isPresented: $isPresentedMeasurementView) {
            MeasurementView()
        }
    }

    // MARK: - Buttons in TabBar -
    var tabBarButtons: some View {
        VStack {
            HStack {
                CustomButtonOnTabBar(
                    selectedIndex: $selectedIndex,
                    index: 0,
                    image: .homeButton,
                    title: L10n.TabBar.Home.title
                )
                .offset(y: 20)
                Spacer(minLength: 0)
                plusBarButton
                Spacer(minLength: 0)
                CustomButtonOnTabBar(
                    selectedIndex: $selectedIndex,
                    index: 1,
                    image: .historyButton,
                    title: L10n.TabBar.History.title
                )
                .offset(y: 20)
            }
            .padding(.horizontal, 72)
            .padding(.top, -10)
            .background(Color.white)
        }
    }

    // MARK: - Body -
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                switch selectedIndex {
                case 0:
                    HomeHealthView(isPopupVisible: $isPopupVisible)
                case 1:
                    HistoryView()
                default:
                    Text("View")
                }
                ZStack {
                    tabBarButtons
                }
            }
            if isPopupVisible {
                Color.black.opacity(0.6)
                    .edgesIgnoringSafeArea(.all)
                PopupInfoView(isPopupVisible: $isPopupVisible)
                    .zIndex(1)
            }
        }
    }
}

#Preview {
    TabBarView()
}
