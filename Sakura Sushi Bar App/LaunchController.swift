//
//  LaunchController.swift
//  Sakura Sushi Bar App
//
//  Created by Josh Jarvis on 07/01/2024.
//

import UIKit

class LaunchController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad();
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
}
