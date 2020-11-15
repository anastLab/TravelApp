//
//  TableCell.swift
//  HomeworkViewController
//
//  Created by AP Nastassia Pakhomava on 8/27/20.
//  Copyright © 2020 AP Nastassia Pakhomava. All rights reserved.
//

import UIKit

class TravelCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var travelCellView: UIView!
    
    @IBOutlet var starsRate: [UIImageView]!
    
    
    
    //MARK: - Life cicle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        travelCellView.layer.cornerRadius = 10
        
        // Initialization code
    }

    

}
