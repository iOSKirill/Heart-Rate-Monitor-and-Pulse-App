//
//  BackButton.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 6.02.24.
//

import SwiftUI

struct BackButton: View {
    // MARK: - Property -
    @Environment(\.dismiss) var dismiss
    @Binding var showTabBar: Bool

    // MARK: - Back button -
    var body: some View {
        Button {
            dismiss()
            showTabBar = true
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
    BackButton(showTabBar: .constant(true))
}
