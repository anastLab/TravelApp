//
//  RegistrationViewController.swift
//  HomeworkViewController
//
//  Created by AP Nastassia Pakhomava on 10/13/20.
//  Copyright © 2020 AP Nastassia Pakhomava. All rights reserved.
//

import UIKit
import Firebase


class RegistrationViewController: UIViewController {
    //MARK: - Outlets
    
    @IBOutlet weak var loginTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    
    //MARK: - Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.layer.cornerRadius = 4
    }
    
    @IBAction func registerClicked(_ sender: Any) {
        let email = loginTF.text ?? ""
        let password = passTF.text ?? ""
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
            guard let self = self else { return }
            guard let user = result?.user else {
                print("Create user error: \(error)")
                return
            }
            print("user succeded")
            
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let travelVC = storyboard.instantiateViewController(identifier: "TravelListViewController")as! TravelListViewController
                self.navigationController?.pushViewController(travelVC, animated: true)
            print("user was registered")
        }
        
    }
    
    
    
    
}
