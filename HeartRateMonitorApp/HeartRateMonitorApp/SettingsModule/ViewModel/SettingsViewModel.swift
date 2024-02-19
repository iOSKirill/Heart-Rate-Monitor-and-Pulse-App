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
    case faq
    case rateUs
}

final class SettingsViewModel: ObservableObject {
    @Published var scrollOffSet: CGFloat = 0.0
    @Published var isShowingMailView = false

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
            print("privacyPolicy")

        case .termsOfUse:
            print("termsOfUse")
            
        case .shareApp:
            print("shareApp")
            
        case .faq:
            print("faq")
            
        case .rateUs:
            print("rateUs")
        }
    }
}

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
