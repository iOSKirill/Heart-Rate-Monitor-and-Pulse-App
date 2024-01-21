//
//  LaunchScreenViewModel.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 9.01.24.
//

import Foundation
import SwiftUI

final class LaunchScreenViewModel: ObservableObject {
    // MARK: - Property -
    @AppStorage("appCondition") var appCondition: AppCondition?
    @Published var isPresentedNextScreen = false
    private(set) var blueGradient = LinearGradient(
        gradient: Gradient(colors: [
            Color.gradientFirstButton,
            Color.gradientSecondButton
        ]),
        startPoint: .top,
        endPoint: .bottom
    )

    func nextPresentedView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.isPresentedNextScreen.toggle()
        }
    }
}
