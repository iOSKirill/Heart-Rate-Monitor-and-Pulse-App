//
//  SettingsViewModel.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 4.12.23.
//

import Foundation
import SwiftUI
import MessageUI

enum SettingsActionState {
    case contactUs
    case privacyPolicy
    case termsOfUse
    case FAQ
}

final class SettingsViewModel: ObservableObject {
    // MARK: - Property -
    @Published var scrollOffSet: CGFloat = 0.0
    @Published var isShowing: Bool = false

    var termsOfUseURL: String { AppConstants.Info.terms }
    var privacyPolicyURL: String { AppConstants.Info.privacy }
    var appStoreURL: String { AppConstants.Info.appStoreURL }
    var faqURL: String { AppConstants.Info.FAQ }

    var state: SettingsActionState {
        didSet {
            guard oldValue != state else { return }
            toggleState()
        }
    }

    // MARK: - Lifecycle -
    init() {
        self.state = .contactUs
    }

    func toggleState() {
        isShowing.toggle()
    }
}

// MARK: - Preview mail view -
struct MailView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool

    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let viewController = MFMailComposeViewController()
        viewController.setToRecipients([AppConstants.Info.supportEmail])
        viewController.setSubject("Contact Us")
        viewController.setMessageBody("", isHTML: false)
        viewController.mailComposeDelegate = context.coordinator
        return viewController
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController,
                                context: UIViewControllerRepresentableContext<MailView>) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(isShowing: $isShowing)
    }

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isShowing: Bool

        init(isShowing: Binding<Bool>) {
            _isShowing = isShowing
        }

        func mailComposeController(_ controller: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?) {
            isShowing = false
        }
    }
}
