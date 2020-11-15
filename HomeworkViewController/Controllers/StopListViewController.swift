//
//  StopListViewController.swift
//  HomeworkViewController
//
//  Created by AP Nastassia Pakhomava on 8/28/20.
//  Copyright © 2020 AP Nastassia Pakhomava. All rights reserved.
//

import UIKit

class StopListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CreateStopViewControllerDelegate {
    
    func didUpdate(stop: Stop) {
        if let indexPath = tableView.indexPathForSelectedRow {
            travel?.stops[indexPath.row] = stop
            tableView.reloadData()
            DataBaseManager.shared.saveTravelInDatabase(travel!)
        }
    }
    
    
    //MARK: - Properties
    var travel: Travel?
    
    //MARK: - Functions
    func didCreate(stop: Stop) {
        travel?.stops.append(stop)
        tableView.reloadData()
        DataBaseManager.shared.saveTravelInDatabase(travel!)
    }
    
    //MARK: - Actions
    @IBAction func addStopClicked(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let createVC = storyboard.instantiateViewController(identifier: "CreateStopViewController")as! CreateStopViewController
        createVC.delegate = self
        createVC.travelId = travel?.id ?? ""
        navigationController?.pushViewController(createVC, animated: true)
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let backButton = UIBarButtonItem()
            backButton.tintColor = #colorLiteral(red: 0.5852046013, green: 0.6206607223, blue: 0.9286258817, alpha: 1)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
    }
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var stopsNavigationBarTitle: UINavigationItem!
    
    //MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travel?.stops.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 141
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StopCell", for: indexPath) as! StopCell
        
        if let stop = travel?.stops[indexPath.row]{
            cell.nameLabel.text = stop.name
            cell.descriptionLabel.text = stop.description
            
            for star in 0..<stop.rating {
                cell.starRateCollection[star].isHighlighted = true
            }
            
            cell.priceLabel.text = stop.currency.rawValue + String(stop.spentMoney)
            
            if stop.transport == .airplain {
                cell.imageTransportView.image = #imageLiteral(resourceName: "Group")
            } else if stop.transport == .car {
                cell.imageTransportView.image = #imageLiteral(resourceName: "Group 3")
            } else if stop.transport == .train {
                cell.imageTransportView.image = #imageLiteral(resourceName: "Group 2")
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let createVC = storyboard.instantiateViewController(identifier: "CreateStopViewController")as! CreateStopViewController
        createVC.delegate = self
        createVC.stop = travel?.stops [indexPath.row]
        createVC.travelId = travel?.id ?? ""
        
        navigationController?.pushViewController(createVC, animated: true)
    }
    
}
