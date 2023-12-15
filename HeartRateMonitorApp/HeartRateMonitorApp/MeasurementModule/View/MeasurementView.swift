//
//  MeasurementView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 15.12.23.
//

import SwiftUI

struct MeasurementView: View {
    // MARK: - Property -
    @StateObject var viewModel = MeasurementViewModel()
    @Environment(\.dismiss) var dismiss

    // MARK: - Close view button -
     var closeViewButton: some View {
         Button {
             dismiss()
         } label: {
             VStack {
                 Image(.navBarCloseButtonIcon)
                     .foregroundColor(Color.mainText)
                     .padding(8)
             }
             .background(.white.opacity(0.6))
             .cornerRadius(12)
         }
         .padding(.top, 32)
     }

    // MARK: - Body -
    var body: some View {
        NavigationView {
            ZStack {
                Color(.backgroundSreens).ignoresSafeArea()
                VStack {
                    Text("Measurement View")
                }
            }
            .navigationBarItems(trailing: closeViewButton)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(L10n.Measurement.NavBar.title)
                        .font(.appUrbanistBold(of: 24))
                        .foregroundColor(Color.mainText)
                        .padding(.top, 32)
                }
            }
        }
    }
}

#Preview {
    MeasurementView()
}
