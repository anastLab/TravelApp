//
//  AlamofireViewController.swift
//  HomeworkViewController
//
//  Created by AP Nastassia Pakhomava on 9/28/20.
//  Copyright © 2020 AP Nastassia Pakhomava. All rights reserved.
//

import UIKit
import Alamofire

class AlamofireViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var textView: UITextView!
    
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        AF.request("https://jsonplaceholder.typicode.com/users").responseJSON { (response) in
            self.textView.text = "\(response.value)"
        }
        AF.request("https://jsonplaceholder.typicode.com/posts",
                   method: .post,
                   parameters: ["Login": "nastya", "password": "1234567890"])
        .responseJSON { (response) in
            self.textView.text = "\(response.value)"
        }
        
    }
    


}
