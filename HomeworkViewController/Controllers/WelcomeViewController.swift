//
//  WelcomeViewController.swift
//  HomeworkViewController
//
//  Created by AP Nastassia Pakhomava on 8/24/20.
//  Copyright © 2020 AP Nastassia Pakhomava. All rights reserved.
//

import UIKit
import FirebaseRemoteConfig
class WelcomeViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    
    
    //MARK: - Cicle
    
    //Срабатывает, когда экран был загружен. Верстки еще нет
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidload")
        roundCorners(button: loginButton, radius: 4)
        createAccountButton.layer.cornerRadius = 4 // то же самое, как строчка выше
        
        /*
         Как работать с remote confige (можно делать кастомные настройки)
         
         let remoteConfig = RemoteConfig.remoteConfig()
         let loginText = remoteConfig["loginButtonText"].stringValue
         loginButton.setTitle(loginText, for: .normal)
         
         let isNeedToShowLoginButton = remoteConfig["isNeedToShowLoginButton"].boolValue
         if isNeedToShowLoginButton == false {
             loginButton.isHidden = true
         }
         */
        
    }
    
    
    override func viewWillAppear (_ animated: Bool) {
       super.viewWillAppear(animated)
       print("viewWillAppear")
    }
    
    override func viewDidAppear (_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDIdDisappear")
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews")
    }
    //MARK: - Functions
     
    func roundCorners(button: UIButton, radius: CGFloat) {
         button.layer.cornerRadius = 4
     }
    
    //MARK: - Actions
    @IBAction func moreLoginClicked(_ sender: Any) {
    }
    
    
    
    
}
