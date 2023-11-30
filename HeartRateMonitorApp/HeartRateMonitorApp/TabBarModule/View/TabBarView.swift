//
//  TabBarView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 29.11.23.
//

import SwiftUI

struct TabBarView: View {
    // MARK: - Property -
    @State var selectedIndex: Int = 2
    // MARK: - Plus button  -
    var plusBarButton: some View {
        Button {
            selectedIndex = 1
        } label: {
            Image(.plusButton)
        }
        .overlay(
            Circle()
                .stroke(Color.white, lineWidth: 3)
        )
        .offset(y: -10)
    }
    // MARK: - Buttons in TabBar -
    var tabBarButtons: some View {
        VStack {
            HStack {
                CustomButtonOnTabBar(selectedIndex: $selectedIndex, index: 0, image: .homeButton, title: "Home")
                .offset(y: 20)
                Spacer(minLength: 0)
                plusBarButton
                Spacer(minLength: 0)
                CustomButtonOnTabBar(selectedIndex: $selectedIndex, index: 2, image: .historyButton, title: "History")
                .offset(y: 20)
            }
            .padding(.horizontal, 72)
            .padding(.top, -10)
            .background(Color.white)
        }
    }
    // MARK: - Body -
    var body: some View {
        VStack(spacing: 0) {
            switch selectedIndex {
            case 0:
                HomeHealthView()
            case 1:
                HistoryView()
            case 2:
                HistoryView()
            default:
                Text("View")
            }
            ZStack {
                tabBarButtons
            }
        }
    }
}

#Preview {
    TabBarView()
}
