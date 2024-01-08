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
    private var heartRateManager: HeartRateManager!
    private var pulseDetector = PulseDetector()
    private var hueFilter = Filter()
    private var timer = Timer()
    private var inputs: [CGFloat] = []
    private var measurementStartedFlag = false
    private var validFrameCounter = 0
    private var measurementSeconds = 0
    @Published var pulseValue: String = "00"
    @Published var lastPulseValue: String = "00"
    @Published var currentStepMeasurement: StepMeasurement = .first
    @Published var isBeatingHeart = false
    @Published var isProgressBar: Float = 0.0
    @Published var scrollOffSet: CGFloat = 0.0

    var stepOneSubtitle: Text {
        let time = L10n.Measurement.StepOne.time
        let parts = L10n.Measurement.StepOne.subtitle(time).components(separatedBy: time)
        return Text(parts[0])
                    .font(.appSemibold(of: 15))
                    .foregroundColor(Color.subtitle) +
               Text(time)
                    .font(.appSemibold(of: 20))
                    .foregroundColor(Color.blueText) +
               Text(parts[1])
                    .font(.appSemibold(of: 15))
                    .foregroundColor(Color.subtitle)
    }

    var measurementTime: Text {
        let formattedSeconds = String(format: "%02d", measurementSeconds)
        let timeTitle = L10n.Measurement.StepTwo.time(formattedSeconds)
        let parts = L10n.Measurement.StepTwo.subtitle(timeTitle).components(separatedBy: timeTitle)
        return Text(parts[0])
                    .font(.appSemibold(of: 15))
                    .foregroundColor(Color.subtitle) +
               Text(timeTitle)
                    .font(.appSemibold(of: 20))
                    .foregroundColor(Color.blueText) +
               Text(parts[1])
                    .font(.appSemibold(of: 15))
                    .foregroundColor(Color.subtitle)
    }

    private func startHeartAnimation() {
        self.isBeatingHeart.toggle()
    }

    private func startProgressBarAnimation() {
        if self.isProgressBar < 1 {
            self.isProgressBar +=  1.0 / 30.0
        } else {
            DispatchQueue.main.async {
                self.timer.invalidate()
            }
        }
    }

    // MARK: - Frames Capture Methods
    func initVideoCapture() {
        let specs = VideoSpec(fps: 30)
        heartRateManager = HeartRateManager(cameraType: .back, preferredSpec: specs)
        heartRateManager.imageBufferHandler = { [unowned self] imageBuffer in
            self.handle(buffer: imageBuffer)
        }
    }

    // MARK: - AVCaptureSession Helpers
    func initCaptureSession() {
        heartRateManager.startCapture()
    }

    func deinitCaptureSession() {
        heartRateManager.stopCapture()
        toggleTorch(status: false)
    }

    private func toggleTorch(status: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        device.toggleTorch(turnOn: status)
    }

    // MARK: - Measurement
     func startMeasurement() {
            DispatchQueue.main.async {
                self.toggleTorch(status: true)
                self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] _ in
                    guard let self = self else { return }
                    let average = self.pulseDetector.getAverage()
                    let pulse = 60.0 / average
                    if pulse == -60 {
                        self.pulseValue = "00"
                    } else {
                        startHeartAnimation()
                        self.pulseValue = "\(lroundf(pulse))"
                        self.lastPulseValue = self.pulseValue
                        self.measurementSeconds += 1
                        startProgressBarAnimation()

                        if measurementSeconds >= 30 {
                            currentStepMeasurement = .third
                            timer.invalidate()
                        }
                    }
                })
            }
        }
}

// MARK: - Handle Image Buffer
extension MeasurementViewModel {
    fileprivate func handle(buffer: CMSampleBuffer) {
        var redmean: CGFloat = 0.0
        var greenmean: CGFloat = 0.0
        var bluemean: CGFloat = 0.0

        let pixelBuffer = CMSampleBufferGetImageBuffer(buffer)
        let cameraImage = CIImage(cvPixelBuffer: pixelBuffer!)

        let extent = cameraImage.extent
        let inputExtent = CIVector(x: extent.origin.x, y: extent.origin.y, z: extent.size.width, w: extent.size.height)
        let averageFilter = CIFilter(name: "CIAreaAverage",
                              parameters: [kCIInputImageKey: cameraImage, kCIInputExtentKey: inputExtent])!
        let outputImage = averageFilter.outputImage!

        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(outputImage, from: outputImage.extent)!

        let rawData: NSData = cgImage.dataProvider!.data!
        let pixels = rawData.bytes.assumingMemoryBound(to: UInt8.self)
        let bytes = UnsafeBufferPointer<UInt8>(start: pixels, count: rawData.length)
        var indexBGRA = 0
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
            validFrameCounter = 0
            measurementStartedFlag = false
            pulseDetector.reset()
            DispatchQueue.main.async {
                print("Cover the back camera until the image turns red 🟥")
                self.timer.invalidate()
                self.isBeatingHeart = false
                self.isProgressBar = 0.0
                self.lastPulseValue = "00"
                self.measurementSeconds = 0
            }
        }
    }
}
