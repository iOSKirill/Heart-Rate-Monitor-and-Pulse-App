//
//  CustomSettingsButton.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 14.12.23.
//

import SwiftUI

struct CustomSettingsButton: View {
    // MARK: - Property -
    let image: UIImage
    let title: String

    // MARK: - Body -
    var body: some View {
        Button {
            // Preview contact us screen
        } label: {
            HStack(spacing: 8) {
                VStack {
                    Image(uiImage: image)
                        .padding(8)
                }
                .background(Color.appPaleBlue)
                .cornerRadius(12)
                Text(title)
                    .font(.appSemibold(of: 15))
                    .foregroundStyle(Color.appMarengo)
                Spacer()
                Image(.settingsArrowIcon)
            }
        }
        .padding(.horizontal, 16)
    }
}
