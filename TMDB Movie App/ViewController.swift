//
//  ViewController.swift
//  TMDB Movie App
//
//  Created by Emre Aydin on 14.01.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Get main view controller
        let mainViewController = MainViewController()
        
        // Push it
        navigationController?.pushViewController(mainViewController, animated: false)
    }


}

