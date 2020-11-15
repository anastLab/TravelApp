//
//  StopDescriptionViewController.swift
//  HomeworkViewController
//
//  Created by AP Nastassia Pakhomava on 8/30/20.
//  Copyright © 2020 AP Nastassia Pakhomava. All rights reserved.
//

import UIKit
import FirebaseDatabase

protocol CreateStopViewControllerDelegate {
    func didCreate(stop: Stop)
    func didUpdate(stop: Stop)
    
}

class CreateStopViewController: UIViewController, SpentMoneyViewControllerDelegate {
    
     //MARK: - Properties
    var travelId: String = ""
    var delegate: CreateStopViewControllerDelegate?
    var stop: Stop?
    var selectedSpendMoney: Double = 0
    var selectedCurrency: Currency = .none
    var selectedGeolacotion: CGPoint = .zero
    var selectedTransport: Transport = .none
    
    //MARK: - Outlets
    @IBOutlet weak var spendMoneyLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var geolocationLabel: UILabel!
    @IBOutlet weak var transportChoiceSegment: UISegmentedControl!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var ratingSegmentView: UIView!
    
    @IBOutlet weak var ratingClickedView: UIView!
    
    //MARK: - Action
    
    @IBOutlet weak var geolocationButton: UIButton!
    @IBOutlet weak var transportSegmentedControl: UISegmentedControl!
    
    @IBAction func minusRatingButton(_ sender: Any) {
        if let text = ratingLabel.text, let currentValue = Int(text){
            ratingLabel.text = String(currentValue - 1)
            if currentValue <= 0 {
                ratingLabel.text = String(0)
            }
        }
        
    }
    
    @IBAction func plusRatingButton(_ sender: Any) {
        if let text = ratingLabel.text, let currentValue = Int(text){
            ratingLabel.text = String(currentValue + 1)
            if currentValue >= 5 {
                ratingLabel.text = String(5)
            }
        }
    }
    @IBAction func spentMoneyClicked(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let spentVC = storyboard.instantiateViewController(identifier: "SpentMoneyViewController")as! SpentMoneyViewController
        spentVC.delegate = self
        present(spentVC, animated: true, completion: nil)
    }
    
    func spent(money: Double, currency: Currency) {
        selectedSpendMoney = money
        selectedCurrency = currency
        spendMoneyLabel.text = String(selectedSpendMoney) + selectedCurrency.rawValue
    }
    
    
    @IBAction func mapClicked(_ sender: Any) {
        let mapVC = MapViewController.fromStoryboard()as! MapViewController
        navigationController?.pushViewController(mapVC, animated: true)
        
        mapVC.closure = { point in
            self.geolocationLabel.text = "\(point.x) - \(point.y)"
            self.selectedGeolacotion = point
        }
    }
    
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ratingSegmentView.layer.cornerRadius = 4
        ratingSegmentView.layer.borderWidth = 1
        ratingSegmentView.layer.borderColor = #colorLiteral(red: 0.5852046013, green: 0.6206607223, blue: 0.9286258817, alpha: 1)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.5852046013, green: 0.6206607223, blue: 0.9286258817, alpha: 1)
        
        let backButton = UIBarButtonItem()
            backButton.title = "Отмена"
            backButton.tintColor = #colorLiteral(red: 0.5852046013, green: 0.6206607223, blue: 0.9286258817, alpha: 1)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        
        descriptionLabel.contentInset.left = 16
        descriptionLabel.contentInset.right = 16
        ratingClickedView.layer.cornerRadius = 4
        ratingClickedView.layer.borderWidth = 1
        ratingClickedView.layer.borderColor = #colorLiteral(red: 0.5852046013, green: 0.6206607223, blue: 0.9286258817, alpha: 1)
        
        
        if let stop = stop {
            spendMoneyLabel.text = String(stop.spentMoney)
            nameTextField.text = stop.name
            ratingLabel.text = String(stop.rating)
            
            let locationString = "\(stop.location.x) - \(stop.location.y)"
            geolocationLabel.text = locationString
            descriptionLabel.text = stop.description
            switch stop.transport {
            
            case .none:
                break
            case .car:
                transportChoiceSegment.selectedSegmentIndex = 2
            case .airplain:
                transportChoiceSegment.selectedSegmentIndex = 0
            case .train:
                transportChoiceSegment.selectedSegmentIndex = 1
            }
            
            selectedCurrency = stop.currency
            selectedSpendMoney = stop.spentMoney
            selectedGeolacotion = stop.location
        }
    }
    
    @objc
    func save() {
        
        if let stop = stop {
            update(stop: stop)
            delegate?.didUpdate(stop: stop)
            sendtoServer(stop: stop)
        } else {
            let id = UUID().uuidString
            let stopNew = Stop(id: id, travelId: travelId)
            update(stop: stopNew)
            delegate?.didCreate(stop: stopNew)
            sendtoServer(stop: stopNew)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func update(stop: Stop) {
        stop.name = nameTextField.text ?? ""
        stop.description = descriptionLabel.text ?? ""
        if transportSegmentedControl.selectedSegmentIndex == 0 {
            selectedTransport = .airplain
        } else if transportSegmentedControl.selectedSegmentIndex == 1 {
            selectedTransport = .train
        } else if transportSegmentedControl.selectedSegmentIndex == 2 {
            selectedTransport = .car
        }
        stop.transport = selectedTransport
        stop.rating = Int(ratingLabel.text ?? "") ?? 0
        stop.location = selectedGeolacotion
        stop.spentMoney = selectedSpendMoney
        stop.currency = selectedCurrency
    }
    
    //MARK: - Functions
    
    func sendtoServer(stop: Stop) {
        let database = Database.database().reference()
        let child = database.child("stops").child("\(stop.id)")
        
        child.setValue(stop.json) { [weak self] (error, ref) in
            print(error, ref)
        }
        
    }
    
}
