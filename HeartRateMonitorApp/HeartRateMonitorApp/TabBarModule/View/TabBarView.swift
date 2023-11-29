//
//  TabBarView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 29.11.23.
//

import SwiftUI

struct TabBarView: View {
    // MARK: - Property -
    @State var selectedIndex: Int = 1
    var plusBarButton: some View {
        Button {
            selectedIndex = 1
        } label: {
            Image(uiImage: .add)
                .renderingMode(.template)
                .font(.system(size: 24,
                              weight: .regular,
                              design: .default))
                .foregroundColor(.white)
                .frame(width: 76, height: 76)
                .background(.blue)
                .cornerRadius(43)
        }
        .overlay(
            Circle()
                .stroke(Color.white, lineWidth: 3)
        )
        .offset(y: -25)
    }
    var tabBarButtons: some View {
        VStack {
            HStack {
                CustomButtonOnTabBar(selectedIndex: $selectedIndex, index: 0, image: .checkmark, title: "Home")
                Spacer(minLength: 12)
                plusBarButton
                Spacer(minLength: 0)
                CustomButtonOnTabBar(selectedIndex: $selectedIndex, index: 2, image: .remove, title: "History")
            }
            .padding(.horizontal, 22)
            .background(Color.white)
        }
    }
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
