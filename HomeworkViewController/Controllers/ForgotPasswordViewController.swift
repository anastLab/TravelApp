//
//  ForgotPasswordViewController.swift
//  HomeworkViewController
//
//  Created by AP Nastassia Pakhomava on 9/3/20.
//  Copyright © 2020 AP Nastassia Pakhomava. All rights reserved.
//

import UIKit
class ForgotPasswordViewController: UIViewController {
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var resetPasswordButton: UIButton!
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        resetPasswordButton.layer.cornerRadius = 4
    }
}
