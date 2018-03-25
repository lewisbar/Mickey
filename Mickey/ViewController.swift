//
//  ViewController.swift
//  Mickey
//
//  Created by Lennart Wisbar on 05.03.18.
//  Copyright © 2018 Lennart Wisbar. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    let captureSession = AVCaptureSession()
    
    private func prepareCaptureSession() {
        guard let audioCaptureDevice = AVCaptureDevice.default(for: .audio) else {
            alert(title: "No input source", message: "The input device could not be initiated.")
            return
        }
        
        do {
            let audioInput = try AVCaptureDeviceInput(device: audioCaptureDevice)
            captureSession.addInput(audioInput)
        } catch {
            alert(title: "Error", message: error.localizedDescription)
        }
        
        // Output
        let audioOutput = AVCaptureAudioDataOutput()
        captureSession.addOutput(audioOutput)
    }
    
    @IBAction func listenButtonPressed(_ sender: UIButton) {
        if !captureSession.isRunning {
            captureSession.startRunning()
        } else {
            captureSession.stopRunning()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareCaptureSession()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Helpers
    func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Close", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

