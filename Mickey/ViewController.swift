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
    
    @IBOutlet weak var listenButton: UIButton!
    let audioEngine = AVAudioEngine()
    var audioSession: AVAudioSession?
    
    func setupAudioSession() throws {
        var options: AVAudioSession.CategoryOptions = [.mixWithOthers]
        if #available(iOS 10.0, *) {
            options.insert([.allowAirPlay, .allowBluetoothA2DP])
        }
        
        audioSession = AVAudioSession.sharedInstance()
        try audioSession?.setCategory(.playAndRecord, mode: .default, options: options)
        try audioSession?.setActive(true)
        //try audioSession?.setPreferredIOBufferDuration(0.005)
        print(audioSession?.inputLatency ?? 0)
        print(audioSession?.outputLatency ?? 0)
//        audioSession?.requestRecordPermission() { [unowned self] allowed in
//            self.isRecordingAllowed = allowed
//        }
    }
    
    func setupAudioEngine() {
        let input = audioEngine.inputNode
        let output = audioEngine.outputNode
        let format = input.inputFormat(forBus: 0)
        
        // Connect nodes
        audioEngine.connect(input, to: output, format: format)
    }
    
    var isOutputEnabled: Bool {
        let outputFormat = audioEngine.outputNode.outputFormat(forBus: 0)
        return outputFormat.channelCount > 0 && outputFormat.sampleRate > 0
    }
    
    func updateListenIcon() {
        if audioEngine.isRunning, isOutputEnabled {
            listenButton.setImage(#imageLiteral(resourceName: "Mickey Icon Active"), for: .normal)
        } else {
            listenButton.setImage(#imageLiteral(resourceName: "Mickey Icon"), for: .normal)
        }
    }
    
    @IBAction func listenButtonPressed(_ sender: UIButton) {
        if audioEngine.isRunning {
            audioEngine.stop()
        } else {
            do {
                try audioEngine.start()
            } catch {
                alert(title: "Error", message: error.localizedDescription)
            }
        }
        updateListenIcon()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudioEngine()
        do {
            try setupAudioSession()
        } catch {
            alert(title: "Error", message: error.localizedDescription)
        }
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

