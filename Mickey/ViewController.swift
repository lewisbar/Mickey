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
    
    func setupAudioEngine() {
        let input = audioEngine.inputNode
        let output = audioEngine.outputNode
        let format = input.inputFormat(forBus: 0)
        
        // Connect nodes
        audioEngine.connect(input, to: output, format: format)
    }
    
    func updateListenIcon() {
        if audioEngine.isRunning {
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

