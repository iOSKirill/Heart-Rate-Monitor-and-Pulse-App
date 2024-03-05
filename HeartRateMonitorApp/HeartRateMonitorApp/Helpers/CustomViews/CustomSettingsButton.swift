//
//  SettingsImageButton.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 14.12.23.
//

import SwiftUI

struct SettingsImageButton: View {
    // MARK: - Property -
    var image: UIImage
    var title: String
    var action: () -> Void

    // MARK: - Body -
    var body: some View {
        Button {
            action()
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
