//
//  ViewController.swift
//  Mickey
//
//  Created by Lennart Wisbar on 05.03.18.
//  Copyright © 2018 Lennart Wisbar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var audio = Audio()

    @IBAction func listenButtonPressed(_ sender: UIButton) {
        do {
            try audio.record()
        } catch {
            alert(title: "Error", message: error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try audio.prepareAudioSession()
            try audio.prepareAudioRecorder(url: getDocumentsDirectory().appendingPathComponent("recording.m4a", isDirectory: false))
            audio.prepareProximityMonitoring()
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
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}

