// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Button {
    internal enum Start {
      /// Tap to start
      internal static let title = L10n.tr("Localizable", "button.start.title", fallback: "Tap to start")
    }
  }
  internal enum Dashboard {
    internal enum Assessment {
      /// Statistics
      internal static let header = L10n.tr("Localizable", "dashboard.assessment.header", fallback: "Statistics")
      /// Take some measurements to see your results
      internal static let mainText = L10n.tr("Localizable", "dashboard.assessment.mainText", fallback: "Take some measurements to see your results")
      /// No data
      internal static let subtitle = L10n.tr("Localizable", "dashboard.assessment.subtitle", fallback: "No data")
      /// Assessment for the week
      internal static let title = L10n.tr("Localizable", "dashboard.assessment.title", fallback: "Assessment for the week")
    }
    internal enum Measure {
      /// Take a measurement to get an assessment of your body's readiness for the upcoming day
      internal static let mainText = L10n.tr("Localizable", "dashboard.measure.mainText", fallback: "Take a measurement to get an assessment of your body's readiness for the upcoming day")
      /// How are you feeling today?
      internal static let subtitle = L10n.tr("Localizable", "dashboard.measure.subtitle", fallback: "How are you feeling today?")
      /// Measure dashboard
      internal static let title = L10n.tr("Localizable", "dashboard.measure.title", fallback: "Measure dashboard")
    }
  }
  internal enum Measurement {
    internal enum NavBar {
      /// Measurement
      internal static let title = L10n.tr("Localizable", "measurement.navBar.title", fallback: "Measurement")
    }
  }
  internal enum NavigationBar {
    internal enum Health {
      /// Health
      internal static let title = L10n.tr("Localizable", "navigationBar.health.title", fallback: "Health")
    }
  }
  internal enum Onboarding {
    /// and
    internal static let and = L10n.tr("Localizable", "onboarding.and", fallback: "and")
    /// Privacy Policy
    internal static let privacyPolicy = L10n.tr("Localizable", "onboarding.privacyPolicy", fallback: "Privacy Policy")
    /// Terms of Service
    internal static let termsOfService = L10n.tr("Localizable", "onboarding.termsOfService", fallback: "Terms of Service")
    internal enum Paywall {
      /// Start to Continue
      internal static let buttonTitle = L10n.tr("Localizable", "onboarding.paywall.buttonTitle", fallback: "Start to Continue")
      /// Start to continue PulseWave app with no limits just for $5,99 per week
      internal static let subtitle = L10n.tr("Localizable", "onboarding.paywall.subtitle", fallback: "Start to continue PulseWave app with no limits just for $5,99 per week")
      /// Start to Continue 
      ///  PulseWave app
      internal static let title = L10n.tr("Localizable", "onboarding.paywall.title", fallback: "Start to Continue \n PulseWave app")
    }
    internal enum StepOne {
      /// Instantly read your heartbeat 
      ///  and track the body's health
      internal static let subtitle = L10n.tr("Localizable", "onboarding.stepOne.subtitle", fallback: "Instantly read your heartbeat \n and track the body's health")
      /// Measure Heart Rate & Pulse
      internal static let title = L10n.tr("Localizable", "onboarding.stepOne.title", fallback: "Measure Heart Rate & Pulse")
    }
    internal enum StepThree {
      /// Get detailed historical records 
      ///  to analyze your heart data
      internal static let subtitle = L10n.tr("Localizable", "onboarding.stepThree.subtitle", fallback: "Get detailed historical records \n to analyze your heart data")
      /// HR Measurements History
      internal static let title = L10n.tr("Localizable", "onboarding.stepThree.title", fallback: "HR Measurements History")
    }
    internal enum StepTwo {
      /// Your rating and feedback allow us to 
      ///  improve the app and add your ideas
      internal static let subtitle = L10n.tr("Localizable", "onboarding.stepTwo.subtitle", fallback: "Your rating and feedback allow us to \n improve the app and add your ideas")
      /// Your ratings 
      ///  Our updates
      internal static let title = L10n.tr("Localizable", "onboarding.stepTwo.title", fallback: "Your ratings \n Our updates")
    }
    internal enum Trial {
      /// Try Free Trial
      internal static let buttonTitle = L10n.tr("Localizable", "onboarding.trial.buttonTitle", fallback: "Try Free Trial")
      /// Start to continue PulseWave app with a 3-day trial and $5,99 per week
      internal static let subtitle = L10n.tr("Localizable", "onboarding.trial.subtitle", fallback: "Start to continue PulseWave app with a 3-day trial and $5,99 per week")
      /// Start to Continue 
      ///  PulseWave app
      internal static let title = L10n.tr("Localizable", "onboarding.trial.title", fallback: "Start to Continue \n PulseWave app")
    }
  }
  internal enum Popup {
    internal enum Hrv {
      /// HRV is an indicator that reflects the unevenness of your heartbeat.
      internal static let subtitle = L10n.tr("Localizable", "popup.HRV.subtitle", fallback: "HRV is an indicator that reflects the unevenness of your heartbeat.")
      /// HRV
      internal static let title = L10n.tr("Localizable", "popup.HRV.title", fallback: "HRV")
    }
    internal enum Assessment {
      /// Evaluation - displays the general state of your body, including conclusions about the level of stress, the work of the central nervous system and other data about the body.
      internal static let subtitle = L10n.tr("Localizable", "popup.assessment.subtitle", fallback: "Evaluation - displays the general state of your body, including conclusions about the level of stress, the work of the central nervous system and other data about the body.")
      /// Assessment
      internal static let title = L10n.tr("Localizable", "popup.assessment.title", fallback: "Assessment")
    }
    internal enum Button {
      /// OK
      internal static let title = L10n.tr("Localizable", "popup.button.title", fallback: "OK")
    }
    internal enum Pulse {
      /// Heart Rate - heart rate, that is, the number of heartbeats per minute.
      internal static let subtitle = L10n.tr("Localizable", "popup.pulse.subtitle", fallback: "Heart Rate - heart rate, that is, the number of heartbeats per minute.")
      /// Pulse
      internal static let title = L10n.tr("Localizable", "popup.pulse.title", fallback: "Pulse")
    }
  }
  internal enum Settings {
    internal enum Faq {
      /// FAQ
      internal static let title = L10n.tr("Localizable", "settings.FAQ.title", fallback: "FAQ")
    }
    internal enum ContactUs {
      /// Contact Us
      internal static let title = L10n.tr("Localizable", "settings.contactUs.title", fallback: "Contact Us")
    }
    internal enum NavBar {
      /// Settings
      internal static let title = L10n.tr("Localizable", "settings.navBar.title", fallback: "Settings")
    }
    internal enum PrivacPolicy {
      /// Privacy Policy
      internal static let title = L10n.tr("Localizable", "settings.privacPolicy.title", fallback: "Privacy Policy")
    }
    internal enum RateUs {
      /// Rate Us
      internal static let title = L10n.tr("Localizable", "settings.rateUs.title", fallback: "Rate Us")
    }
    internal enum ShareThisApp {
      /// Share This App
      internal static let title = L10n.tr("Localizable", "settings.shareThisApp.title", fallback: "Share This App")
    }
    internal enum TermsOfUse {
      /// Terms of Use
      internal static let title = L10n.tr("Localizable", "settings.termsOfUse.title", fallback: "Terms of Use")
    }
  }
  internal enum TabBar {
    internal enum History {
      /// History
      internal static let title = L10n.tr("Localizable", "tabBar.history.title", fallback: "History")
    }
    internal enum Home {
      /// Localizable.strings
      ///   HeartRateMonitorApp
      /// 
      ///   Created by Kirill Manuilenko on 29.11.23.
      internal static let title = L10n.tr("Localizable", "tabBar.home.title", fallback: "Home")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
