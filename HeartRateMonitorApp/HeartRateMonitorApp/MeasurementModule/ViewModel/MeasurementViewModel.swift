//
//  MeasurementViewModel.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 15.12.23.
//

import AVFoundation
import CoreImage
import Foundation
import SwiftUI
import Combine

enum StepMeasurement {
    case first
    case second
    case third
}

final class MeasurementViewModel: ObservableObject {
    // MARK: - Property -
    @Published var pulseValue: String = "00"
    @Published var lastPulseValue: String = "00"
    @Published var currentStepMeasurement: StepMeasurement = .first
    @Published var isBeatingHeart = false
    @Published var isProgressBar: Float = 0.0
    @Published var scrollOffSet: CGFloat = 0.0
    @Published var isPresentedHomeHealthView: Bool = false

    private(set) var title: String = ""
    private(set) var progress: Float = 0.0
    private(set) var buttonTitle: String = ""
    private(set) var notNowButtonTitle: String = ""

    private(set) var buttonGradient = Gradient(colors: [
        .appBlueGradientFirstButton,
        .appBlueGradientSecondButton
    ])

    enum State {
        case initial
        case inProgress
        case finished
    }

    private var state: State {
        didSet {
            guard oldValue != state else { return }
            didUpdateState()
        }
    }

    var descriptionText: Text? {
        switch state {
        case .initial:
            return stepOneSubtitle

        case .inProgress:
            return measurementTime

        case .finished:
            return nil
        }
    }

    var stepOneSubtitle: Text {
        let time = L10n.Measurement.StepOne.time
        let parts = L10n.Measurement.StepOne.subtitle(time).components(separatedBy: time)
        return Text(parts[0])
                    .font(.appSemibold(of: 15))
                    .foregroundColor(Color.appSlateGrey) +
               Text(time)
                    .font(.appSemibold(of: 20))
                    .foregroundColor(Color.appBlue) +
               Text(parts[1])
                    .font(.appSemibold(of: 15))
                    .foregroundColor(Color.appSlateGrey)
    }

    var measurementTime: Text {
        let formattedSeconds = String(format: "%02d", measurementSeconds)
        let timeTitle = L10n.Measurement.StepTwo.time(formattedSeconds)
        let parts = L10n.Measurement.StepTwo.subtitle(timeTitle).components(separatedBy: timeTitle)
        return Text(parts[0])
                    .font(.appSemibold(of: 15))
                    .foregroundColor(Color.appSlateGrey) +
               Text(timeTitle)
                    .font(.appSemibold(of: 20))
                    .foregroundColor(Color.appBlue) +
               Text(parts[1])
                    .font(.appSemibold(of: 15))
                    .foregroundColor(Color.appSlateGrey)
    }

    private var validFrameCounter = 0
    private var heartRateManager: HeartRateManager?
    private var hueFilter = Filter()
    private var pulseDetector = PulseDetector()
    private var inputs: [CGFloat] = []
    private var measurementStartedFlag = false
    private var measurementSeconds = 30

    private var timerSubscription: AnyCancellable?

    private var realmManager: RealmManagerProtocol = RealmManager()
    private var timeMeasurement: Date = Date()

    // MARK: - Lifecycle -
    init() {
        self.state = .initial
        didUpdateState()
    }

    // MARK: - Public -
    func toggleState() {
        switch state {
        case .initial:
            state = .inProgress

        case .inProgress:
            state = .initial

        case .finished:
            timeMeasurement = .now
            realmManager.addLastMeasurement(valueMeasurement: lastPulseValue, timeMeasurement: timeMeasurement)
            isPresentedHomeHealthView.toggle()
        }
    }

    // MARK: - Measurement -
    func startMeasurement() {
        toggleTorch(status: true)
        stopTimer()
        progress = 0.0

        timerSubscription = Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }

                let average = self.pulseDetector.getAverage()
                let pulse = 60.0 / average
                if pulse == -60 {
                    self.pulseValue = "00"
                } else {
                    self.pulseValue = "\(lroundf(pulse))"
                    self.lastPulseValue = self.pulseValue
                    self.measurementSeconds -= 1
                    self.updateProgress()

                    if measurementSeconds <= 0 {
                        self.state = .finished
                        self.didUpdateState()
                    }
                }
            }
    }
}

// MARK: - Private -
private extension MeasurementViewModel {
    func didUpdateState() {
        title = state.title
        isBeatingHeart = state.isHeartbeating
        buttonGradient = state.buttonGradient
        buttonTitle = state.buttonTitle
        notNowButtonTitle = state.notNowButtonTitle

        switch state {
        case .initial:
            currentStepMeasurement = .first
            progress = 0.0
            measurementSeconds = 30
            pulseValue = "00"
            lastPulseValue = "00"
            stopTimer()
            deinitCaptureSession()

        case .inProgress:
            currentStepMeasurement = .second
            progress = 0.0
            setupVideoCapture()
            setupCaptureSession()

        case .finished:
            currentStepMeasurement = .third
            progress = 1.0
            deinitCaptureSession()
        }
    }

    func updateProgress() {
        guard isProgressBar < 1 else {
            stopTimer()
            return
        }
        isProgressBar +=  1.0 / 30.0
        progress = self.isProgressBar
    }

    func deinitCaptureSession() {
        heartRateManager?.stopCapture()
        toggleTorch(status: false)
    }

    func setupVideoCapture() {
        let specs = VideoSpec(fps: 30)
        heartRateManager = HeartRateManager(cameraType: .back, preferredSpec: specs)
        heartRateManager?.imageBufferHandler = { [weak self] imageBuffer in
            self?.handle(buffer: imageBuffer)
        }
    }

    func setupCaptureSession() {
        heartRateManager?.startCapture()
    }

    func toggleTorch(status: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        device.toggleTorch(turnOn: status)
    }

    func stopTimer() {
        timerSubscription?.cancel()
        timerSubscription = nil
    }
}

// MARK: - State Utils -
private extension MeasurementViewModel.State {
    var title: String {
        switch self {
        case .initial:
            return L10n.Measurement.StepOne.title

        case .inProgress:
            return L10n.Measurement.StepTwo.title

        case .finished:
            return L10n.Measurement.StepThree.title
        }
    }

    var buttonTitle: String {
        switch self {
        case .initial:
            return L10n.Measurement.StepOne.button

        case .inProgress:
            return L10n.Measurement.StepTwo.button

        case .finished:
            return L10n.Measurement.StepThree.Button.save
        }
    }

    var buttonGradient: Gradient {
        switch self {
        case .initial, .finished:
            return Gradient(colors: [.appBlueGradientFirstButton, .appBlueGradientSecondButton])

        case .inProgress:
            return Gradient(colors: [.appRedGradientFirstButton, .appRedGradientSecondButton])
        }
    }

    var isHeartbeating: Bool {
        switch self {
        case .initial, .finished:
            return false

        case .inProgress:
            return true
        }
    }

    var notNowButtonTitle: String {
        switch self {
        case .initial, .inProgress:
            return ""

        case .finished:
            return L10n.Measurement.StepThree.Button.notNow
        }
    }
}

// MARK: - Handle Image Buffer
private extension MeasurementViewModel {
    func handle(buffer: CMSampleBuffer) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(buffer) else { return }
        processBuffer(pixelBuffer: pixelBuffer)
    }

    func processBuffer(pixelBuffer: CVPixelBuffer) {
        let cameraImage = CIImage(cvPixelBuffer: pixelBuffer)
        let extent = cameraImage.extent
        let inputExtent = CIVector(x: extent.origin.x, y: extent.origin.y, z: extent.size.width, w: extent.size.height)
        guard let averageFilter = CIFilter(
            name: "CIAreaAverage",
            parameters: [kCIInputImageKey: cameraImage, kCIInputExtentKey: inputExtent]
        ),
              let outputImage = averageFilter.outputImage,
              let cgImage = CIContext(options: nil).createCGImage(outputImage, from: outputImage.extent),
              let rawData: NSData = cgImage.dataProvider?.data else { return }
        processRawData(rawData: rawData)
    }

    func processRawData(rawData: NSData) {
        let pixels = rawData.bytes.assumingMemoryBound(to: UInt8.self)
        let bytes = UnsafeBufferPointer<UInt8>(start: pixels, count: rawData.length)

        var indexBGRA = 0
        var redmean: CGFloat = 0.0
        var greenmean: CGFloat = 0.0
        var bluemean: CGFloat = 0.0

        for pixel in UnsafeBufferPointer(start: bytes.baseAddress, count: bytes.count) {
            switch indexBGRA {
            case 0:
                bluemean = CGFloat(pixel)

            case 1:
                greenmean = CGFloat(pixel)

            case 2:
                redmean = CGFloat(pixel)

            case 3:
                break

            default:
                break
            }
            indexBGRA += 1
        }

        let hsv = convertRGBtoHSV(RGB(red: redmean, green: greenmean, blue: bluemean, alpha: 1.0))
        processHSV(hsv: hsv)
    }

    func processHSV(hsv: HSV) {
        if hsv.saturation > 0.5 && hsv.brightness > 0.5 {
            DispatchQueue.main.async {
                self.toggleTorch(status: true)
                if !self.measurementStartedFlag {
                    self.startMeasurement()
                    self.measurementStartedFlag = true
                }
            }
            validFrameCounter += 1
            inputs.append(hsv.hue)

            let filtered = hueFilter.processValue(value: Double(hsv.hue))
            if validFrameCounter > 60 {
                _ = self.pulseDetector.addNewValue(newVal: filtered, atTime: CACurrentMediaTime())
            }
        } else {
            resetMeasurement()
        }
    }

    func resetMeasurement() {
        validFrameCounter = 0
        measurementStartedFlag = false
        pulseDetector.reset()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.stopTimer()
            self.isBeatingHeart = false
            self.isProgressBar = 0
            self.progress = 0.0
            self.measurementSeconds = 30
            self.pulseValue = "00"
            self.lastPulseValue = "00"
        }
    }
}
