//
//  ViewController.swift
//  VkNewsFeed
//
//  Link to the course
//  https://swiftbook.ru/content/27-index/
//
//  Created by test on 08.07.2022.
//

import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        authService = SceneDelegate.shared().authService
    }

    @IBAction func connectToVk(_ sender: Any) {
        authService.wakeUpSession()
    }
}
