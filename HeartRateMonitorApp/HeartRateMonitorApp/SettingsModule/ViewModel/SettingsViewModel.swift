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
    case shareApp
    case FAQ
}

final class SettingsViewModel: ObservableObject {
    // MARK: - Property -
    @Published var scrollOffSet: CGFloat = 0.0
    @Published var isShowingMailView = false
    @Published var isShowingPrivacyPolicy = false
    @Published var isShowingTermsOfUse = false
    @Published var isShowingFAQ = false

    let termsOfUseURL = AppConstants.terms
    let privacyPolicyURL = AppConstants.privacy
    let faqURL = AppConstants.FAQ

    private let appStoreURL = AppConstants.appStoreURL

    var state: SettingsActionState {
        didSet {
            guard oldValue != state else { return }
        }
    }

    // MARK: - Lifecycle -
    init() {
        self.state = .contactUs
    }

    func toggleState() {
        switch state {
        case .contactUs:
            isShowingMailView.toggle()

        case .privacyPolicy:
            isShowingPrivacyPolicy.toggle()

        case .termsOfUse:
            isShowingTermsOfUse.toggle()

        case .shareApp:
            print("shareApp")

        case .FAQ:
            isShowingFAQ.toggle()
        }
    }
}

// MARK: - Preview mail view -
struct MailView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool

    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let viewController = MFMailComposeViewController()
        viewController.setToRecipients([AppConstants.supportEmail])
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
