//
//  HomeHealthView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 29.11.23.
//

import SwiftUI

struct HomeHealthView: View {
    // MARK: - Settings button -
    var settingsButton: some View {
        Button {
            // Go to the settings screen
        } label: {
            VStack {
                Image(.settingsButton)
                    .padding(8)
            }
            .background(Color.white)
            .cornerRadius(12)
            .padding(.top, 16)
            .padding(.bottom, 13)
        }
    }
    // MARK: - Body -
    var body: some View {
        NavigationView {
            ZStack {
                Color(.backgroundSreens).ignoresSafeArea()
                VStack {
                    ScrollView(showsIndicators: false) {
                        Spacer()
                        Text("Home screen")
                        Spacer()
                    }
                }
                
            }
            .navigationBarItems(leading: 
                                    Text(L10n.healthNavigationTitile) .font(.urbanistBold(size: 32))
                                        .foregroundColor(.mainText)
                                        .padding(.top, 16)
                                        .padding(.bottom, 13),
                                trailing: settingsButton)
        }
    }
}

#Preview {
    HomeHealthView()
}
