//
//  CustomButtinOnTabBar.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 29.11.23.
//

import SwiftUI

struct CustomButtonOnTabBar: View {
    // MARK: - Property -
    @Binding var selectedIndex: Int
    let index: Int
    let image: UIImage
    let title: String
    // MARK: - Body -
    var body: some View {
        Button {
            selectedIndex = index
        } label: {
            VStack {
                Image(uiImage: image)
                    .renderingMode(.template)
                    .padding(.bottom, 4)
                Text(title)
                    .font(.gilroyBold(size: 11))
            }
            .padding(.bottom, 20)
        }
        .foregroundColor(selectedIndex == index ? Color(.notHighlightedButton) : Color(.highlightedButton))
    }
}
