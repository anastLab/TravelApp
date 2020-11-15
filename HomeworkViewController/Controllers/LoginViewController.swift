//
//  LoginViewController.swift
//  HomeworkViewController
//
//  Created by AP Nastassia Pakhomava on 8/24/20.
//  Copyright © 2020 AP Nastassia Pakhomava. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var separatorEmail: UIView!
    @IBOutlet weak var separatorPassword: UIView!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    //MARK: - Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidload")
        let backButton = UIBarButtonItem()
            backButton.tintColor = #colorLiteral(red: 0.5852046013, green: 0.6206607223, blue: 0.9286258817, alpha: 1)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        loginButton.layer.cornerRadius = 4
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
    
    deinit {
        print("deinit")
    }
    
    //MARK: - Functions
    
    
    //MARK: - Actions
    @IBAction func loginClicked(_ sender: Any) {
        
        let email = emailTF.text ?? ""
        let password = passwordTF.text ?? ""
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (result, error) in
            guard let self = self else { return } // Чтобы self не делать опциональным из-за [weak self].
            guard let user = result?.user else {
                self.separatorEmail.layer.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
                self.separatorPassword.layer.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
                self.passwordLabel.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
                self.emailLabel.textColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
                print("Create Login error: \(error)")
                return
            }
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let travelVC = storyboard.instantiateViewController(identifier: "TravelListViewController")as! TravelListViewController
                self.navigationController?.pushViewController(travelVC, animated: true)
            print("user was logged")
        }
        
    }
    
}
