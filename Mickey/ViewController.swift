//
//  ViewController.swift
//  Mickey
//
//  Created by Lennart Wisbar on 05.03.18.
//  Copyright © 2018 Lennart Wisbar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func listenButtonPressed(_ sender: UIButton) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

