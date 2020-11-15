//
//  LoadingViewController.swift
//  HomeworkViewController
//
//  Created by AP Nastassia Pakhomava on 10/22/20.
//  Copyright © 2020 AP Nastassia Pakhomava. All rights reserved.
//

import UIKit
import FirebaseRemoteConfig
import FirebaseAuth

class LoadingViewController: UIViewController {

    @IBAction func buttonClicked(_ sender: Any) {
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.setValue("purple", forKey: "themeColorKey") // Это для сохранения пользовательских кастомных настроек, например, темы розовой и тд. Следующая строчка тоже.
        let value = UserDefaults.standard.value(forKey: "themeColorKey")
        let remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.fetchAndActivate { [weak self] (status, error) in
            DispatchQueue.main.async { [weak self] in
                if let user = Auth.auth().currentUser?.uid {
                    self?.showTravelList()
                } else {
                    self?.showWelcomeScreen()
                }
//                let controller = XibViewController()
//                self?.navigationController?.pushViewController(controller, animated: true)
//
            }
            
        }
    }
    
    func showWelcomeScreen() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let welcomeVC = storyboard.instantiateViewController(identifier: "WelcomeViewController")as! WelcomeViewController
            self.navigationController?.pushViewController(welcomeVC, animated: true)
    }
    
    func showTravelList() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "TravelListViewController")as! TravelListViewController
            self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
