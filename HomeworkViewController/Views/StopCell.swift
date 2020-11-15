//
//  StopCell.swift
//  HomeworkViewController
//
//  Created by AP Nastassia Pakhomava on 8/28/20.
//  Copyright © 2020 AP Nastassia Pakhomava. All rights reserved.
//

import UIKit

class StopCell: UITableViewCell {
    
    //MARK: - Outlets
   
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stopCellView: UIView!
    @IBOutlet weak var imageTransportView: UIImageView!
    @IBOutlet weak var rateStackView: UIStackView!
    

    @IBOutlet var starRateCollection: [UIImageView]!
    
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        stopCellView.layer.cornerRadius = 10
        imageTransportView.layer.cornerRadius = 11
        
    }



}
