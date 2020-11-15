//
//  UIViewController+Ex.swift
//  HomeworkViewController
//
//  Created by AP Nastassia Pakhomava on 9/28/20.
//  Copyright © 2020 AP Nastassia Pakhomava. All rights reserved.
//

import UIKit

extension UIViewController {
    class func fromStoryboard() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let identifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
