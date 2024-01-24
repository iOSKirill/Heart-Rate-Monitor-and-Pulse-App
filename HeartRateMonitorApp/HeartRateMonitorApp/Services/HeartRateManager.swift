//
//  HeartRateManager.swift
//  HeartRateMonitorApp
//
//  Created by Kirill Manuilenko on 20.12.23.
//

import AVFoundation
import Foundation

enum CameraType: Int {
    case back
    case front

    func captureDevice() -> AVCaptureDevice? {
        switch self {
        case .front:
            let devices = AVCaptureDevice.DiscoverySession(deviceTypes: [],
                                                           mediaType: AVMediaType.video,
                                                           position: .front).devices
            print("devices:\(devices)")
            for device in devices where device.position == .front {
                return device
            }

        default:
            break
        }
        return AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back)
    }
}

struct VideoSpec {
    var fps: Int32?
    var size: CGSize?
}

typealias ImageBufferHandler = ((_ imageBuffer: CMSampleBuffer) -> Void)

final class HeartRateManager: NSObject {
    private let captureSession = AVCaptureSession()
    private let videoDevice: AVCaptureDevice
    private var videoConnection: AVCaptureConnection!
    private var audioConnection: AVCaptureConnection!
    private var previewLayer: AVCaptureVideoPreviewLayer?

    var imageBufferHandler: ImageBufferHandler?

    init?(cameraType: CameraType, preferredSpec: VideoSpec?) {
        guard let videoDevice = cameraType.captureDevice() else {
            return nil
        }

        self.videoDevice = videoDevice

        super.init()

        // Setup Video Format
        do {
            captureSession.sessionPreset = .low
            if let preferredSpec {
                // Update the format with a preferred fps
                videoDevice.updateFormatWithPreferredVideoSpec(preferredSpec: preferredSpec)
            }
        }

        // Setup video device input
        let videoDeviceInput: AVCaptureDeviceInput
        do {
            videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
        } catch {
            fatalError("Could not create AVCaptureDeviceInput instance with error: \(error).")
        }
        guard captureSession.canAddInput(videoDeviceInput) else { fatalError() }
        captureSession.addInput(videoDeviceInput)

        // Setup video output
        let videoDataOutput = AVCaptureVideoDataOutput()
        videoDataOutput.videoSettings = [
            kCVPixelBufferPixelFormatTypeKey: NSNumber(value: kCVPixelFormatType_32BGRA)
        ] as [String: Any]
        videoDataOutput.alwaysDiscardsLateVideoFrames = true
        let queue = DispatchQueue(label: "com.covidsense.videosamplequeue")
        videoDataOutput.setSampleBufferDelegate(self, queue: queue)
        guard captureSession.canAddOutput(videoDataOutput) else {
            fatalError()
        }
        captureSession.addOutput(videoDataOutput)
        videoConnection = videoDataOutput.connection(with: .video)
    }

    func startCapture() {
        #if DEBUG
        print(#function + "\(self.classForCoder)/")
        #endif
        if captureSession.isRunning {
            #if DEBUG
            print("Capture Session is already running 🏃‍♂️.")
            #endif
            return
        }
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
    }

    func stopCapture() {
        #if DEBUG
        print(#function + "\(self.classForCoder)/")
        #endif
        if !captureSession.isRunning {
            #if DEBUG
            print("Capture Session has already stopped 🛑.")
            #endif
            return
        }
        captureSession.stopRunning()
    }
}

// MARK: - Export buffer from video frame

extension HeartRateManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput,
                       didOutput sampleBuffer: CMSampleBuffer,
                       from connection: AVCaptureConnection) {
        if connection.videoOrientation != .portrait {
            connection.videoOrientation = .portrait
            return
        }

        imageBufferHandler?(sampleBuffer)
    }
}
