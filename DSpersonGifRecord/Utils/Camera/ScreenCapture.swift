//
//  ScreenCapture.swift
//  DSpersonGifRecord
//
//  Created by DSperson on 2019/5/20.
//  Copyright © 2019 DSperson. All rights reserved.
//

import AVFoundation

protocol ScreenCaptureDelegate: class {
    func screenStateDidChange(state : RecordState, error : Error?, path : URL?)
}
public class ScreenCapture: NSObject {
    
    fileprivate let session : AVCaptureSession
    fileprivate let rect : NSRect
    fileprivate let input : AVCaptureScreenInput
    fileprivate let output : AVCaptureMovieFileOutput
    fileprivate let saver : GifSaver
    fileprivate weak var delegate : ScreenCaptureDelegate?
    init(rect : NSRect, delegate: ScreenCaptureDelegate) {
        self.rect = rect
        self.delegate = delegate
        session = AVCaptureSession()
        session.sessionPreset = .high
        ///u获取当前display id
        input = AVCaptureScreenInput(displayID: CGMainDisplayID())!
        input.cropRect = rect
        if session.canAddInput(input) {
            session.addInput(input)
        }
        output = AVCaptureMovieFileOutput()
        if session.canAddOutput(output) {
            session.addOutput(output)
        }
        saver = GifSaver()
    }
    
    public func record() {
        let tempVideoURL = URL(fileURLWithPath: NSTemporaryDirectory())
        .appendingPathComponent(UUID().uuidString)
        .appendingPathExtension("mov")
        session.startRunning()
        output.startRecording(to: tempVideoURL, recordingDelegate: self)
    }
    public func pause() {
        output.pauseRecording()
    }
    public func resume() {
        output.resumeRecording()
    }
    public func stop() {
        output.stopRecording()
        session.stopRunning()
    }
}
extension ScreenCapture: AVCaptureFileOutputRecordingDelegate {
    public func fileOutput(_ output: AVCaptureFileOutput, didStartRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        StatusControlManager.share.state = .record
    }
    public func fileOutput(_ output: AVCaptureFileOutput, didPauseRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        StatusControlManager.share.state = .pause
    }
    public func fileOutput(_ output: AVCaptureFileOutput, didResumeRecordingTo fileURL: URL, from connections: [AVCaptureConnection]) {
        StatusControlManager.share.state = .resume
    }
    public func fileOutput(_ output: AVCaptureFileOutput, willFinishRecordingTo fileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        
    }
    public func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
//        StatusControlManager.share.state = .stop
        saver.save(videoURL: outputFileURL) { [weak self](url) in
            self?.delegate?.screenStateDidChange(state: .finsh, error: error, path: url)
        }
    }
}
