//
//  CustomPopupVStackInfo.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 8.12.23.
//

import SwiftUI

struct CustomPopupVStackInfo: View {
    // MARK: - Property -
    let image: UIImage
    let title: String
    let subtitle: String

    // MARK: - Body -
    var body: some View {
        VStack(spacing: 6) {
            HStack(spacing: 8) {
                Image(uiImage: image)
                Text(title)
                    .font(.appSemibold(of: 16))
                    .foregroundColor(Color.appMarengo)
                Spacer()
            }
            .padding(.leading, 16)

            HStack {
                Text(subtitle)
                    .font(.appMedium(of: 14))
                    .foregroundColor(Color.appSlateGrey)
                Spacer()
            }
            .padding(.horizontal, 16)
        }
    }
}
