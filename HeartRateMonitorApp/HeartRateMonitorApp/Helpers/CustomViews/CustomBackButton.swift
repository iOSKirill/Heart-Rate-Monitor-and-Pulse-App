//
//  CustomBackButton.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 6.02.24.
//

import SwiftUI

struct CustomBackButton: View {
    // MARK: - Property -
    @Environment(\.dismiss) var dismiss

    // MARK: - Back button -
    var body: some View {
        Button {
            dismiss()
        } label: {
            VStack {
                Image(.navBarBackButtonIcon)
                    .foregroundColor(Color.appMarengo)
                    .padding(10)
            }
            .background(Color.white)
            .cornerRadius(12)
        }
    }
}

#Preview {
    CustomBackButton()
}
