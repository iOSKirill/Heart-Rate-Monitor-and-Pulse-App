//
//  HomeHealthView.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 29.11.23.
//

import SwiftUI

struct HomeHealthView: View {
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            VStack {
                Spacer()
                Text("Home screen")
                Spacer()
            }
        }
    }
}

#Preview {
    HomeHealthView()
}
