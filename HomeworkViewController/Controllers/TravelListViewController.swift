//
//  TravelListViewController.swift
//  HomeworkViewController
//
//  Created by AP Nastassia Pakhomava on 8/27/20.
//  Copyright © 2020 AP Nastassia Pakhomava. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import RealmSwift

class TravelListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var travels: [Travel] = []
    var travelsNotification: NotificationToken!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem()
            backButton.tintColor = #colorLiteral(red: 0.5852046013, green: 0.6206607223, blue: 0.9286258817, alpha: 1)
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.5852046013, green: 0.6206607223, blue: 0.9286258817, alpha: 1)
        
        let travelsObjects = DataBaseManager.shared.getObjects(classType: RLMTravel.self)
        let stopsObjects = DataBaseManager.shared.getObjects(classType: RLMStop.self)
        
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib.init(nibName: "TravelXibCell", bundle: nil) // Зарегистри
        tableView.register(nib, forCellReuseIdentifier: "TravelXibCell")
        
        observeTravels()
        
        travels = DataBaseManager.shared.getTravels()
        getTravelsFromServer()
        getStopsFromServer()
        
        
        let resultJson = travels.map({$0.json})
        
        
        
        //    let travel1 = Travel.init(name: "Италия", description: "Белиссимо")
        //    travels.append(travel1)
        //
        //    let stop1Italy = Stop()
        //    stop1Italy.name = "Рим"
        //    stop1Italy.rating = 5
        //    stop1Italy.spentMoney = 150
        //    stop1Italy.currency = .dollar
        //    stop1Italy.description = "Две недели в Риме"
        //    travel1.stops.append(stop1Italy)
        //
        //
        //    let stop2Italy = Stop()
        //    stop2Italy.name = "Милан"
        //    stop2Italy.rating = 4
        //    stop2Italy.spentMoney = 10
        //    stop2Italy.currency = .euro
        //    stop2Italy.description = "Две недели в Милане"
        //    travel1.stops.append(stop2Italy)
        //
        //    let stop3Italy = Stop()
        //    stop3Italy.name = "Неаполь"
        //    stop3Italy.rating = 3
        //    stop3Italy.description = "Две недели в Неаполе"
        //    stop3Italy.spentMoney = 10
        //    stop3Italy.currency = .euro
        //    travel1.stops.append(stop3Italy)
        //
        //
        //
        //    let travel2 = Travel.init(name: "Германия", description: "Danke")
        //    travels.append(travel2)
        //
        //    let stop1Germany = Stop()
        //    stop1Germany.name = "Мюнхен"
        //    stop1Germany.rating = 4
        //    stop1Germany.description = "Мюнхен и замок Нойшванштайн"
        //    stop1Germany.spentMoney = 10
        //    stop1Germany.currency = .euro
        //    travel2.stops.append(stop1Germany)
        //
        //    let stop2Germany = Stop()
        //    stop2Germany.name = "Берлин"
        //    stop2Germany.rating = 5
        //    stop2Germany.description = "Берлин ОГОНЬ!"
        //    stop2Germany.spentMoney = 10
        //    stop2Germany.currency = .euro
        //    travel2.stops.append(stop2Germany)
        //
        //    let stop3Germany = Stop()
        //    stop3Germany.name = "Дрезден"
        //    stop3Germany.rating = 3
        //    stop3Germany.description = "Советую посетить Дрезден"
        //    stop3Germany.spentMoney = 10
        //    stop3Germany.currency = .euro
        //    travel2.stops.append(stop3Germany)
        //
        //
        //
        //    let travel3 = Travel.init(name: "Чехия", description: "Спашшшибо")
        //    travels.append(travel3)
        //
        //    let stop1Czech = Stop()
        //    stop1Czech.name = "Прага"
        //    stop1Czech.rating = 5
        //    stop1Czech.description = "Прага в апреле"
        //    stop1Czech.spentMoney = 10
        //    stop1Czech.currency = .euro
        //    travel3.stops.append(stop1Czech)
        //
        //    let stop2Czech = Stop()
        //    stop2Czech.name = "Брно"
        //    stop2Czech.rating = 4
        //    stop2Czech.description = "Брно в апреле"
        //    stop2Czech.spentMoney = 10
        //    stop2Czech.currency = .euro
        //    travel3.stops.append(stop2Czech)
        //
        //    let stop3Czech = Stop()
        //    stop3Czech.name = "Кралики"
        //    stop3Czech.rating = 3
        //    stop3Czech.description = "Кралики в апреле"
        //    stop3Czech.spentMoney = 10
        //    stop3Czech.currency = .euro
        //    travel3.stops.append(stop3Czech)
        //
        //
        //
        //    let travel4 = Travel.init(name: "Нидерланды", description: "Данке Шон")
        //    travels.append(travel4)
        //
        //    let stop1Dutch = Stop()
        //    stop1Dutch.name = "Амстердам"
        //    stop1Dutch.rating = 3
        //    stop1Dutch.description = "День короля в Амстердаме"
        //    stop1Dutch.spentMoney = 10
        //    stop1Dutch.currency = .euro
        //    travel4.stops.append(stop1Dutch)
        //
        //    let stop2Dutch = Stop()
        //    stop2Dutch.name = "Гаага"
        //    stop2Dutch.rating = 3
        //    stop2Dutch.description = "День короля в Гааге"
        //    stop2Dutch.spentMoney = 10
        //    stop2Dutch.currency = .euro
        //    travel4.stops.append(stop2Dutch)
        //
        //    let stop3Dutch = Stop()
        //    stop3Dutch.name = "Гауда"
        //    stop3Dutch.rating = 3
        //    stop3Dutch.description = "День короля в Гауде"
        //    stop3Dutch.spentMoney = 10
        //    stop3Dutch.currency = .euro
        //    travel4.stops.append(stop3Dutch)
        //
        //
        //
        //    let travel5 = Travel.init(name: "США", description: "Автостопом")
        //    travels.append(travel5)
        //
        //    let stop1Us = Stop()
        //    stop1Us.name = "Нью-Йорк"
        //    stop1Us.rating = 5
        //    stop1Us.description = "Большое яблоко супер!"
        //    stop1Us.spentMoney = 10
        //    stop1Us.currency = .dollar
        //    travel5.stops.append(stop1Us)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dotsView: DotsActivityIndicator!
    @IBOutlet weak var beforeTravelsLabel: UILabel!
    
    //MARK: - Actions
    @IBAction func addTravelButton(_ sender: Any) {
        
        let alertController = UIAlertController.init(title: "Добавить путешествие", message: "Введите название и описание", preferredStyle: .alert)
        
        
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) {
            [weak self] (action) in
            guard let self = self else { return }
            let firstTextField = alertController.textFields?[0]
            let secondTextField = alertController.textFields?[1]
            
            if let name = firstTextField?.text, let desc = secondTextField?.text {
                let id = UUID().uuidString
                if let userId = Auth.auth().currentUser?.uid {
                    let travel = Travel(userId: userId, id: id, name: name, description: desc)
                    self.travels.append(travel)
                    self.tableView.reloadData()
                    self.sendtoServer(travel: travel)
                    DataBaseManager.shared.saveTravelInDatabase(travel)
                    
                }
            }
        }
        // DataBaseManager.shared.array.append(<#T##newElement: String##String#>) пример обращения к синглтону
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel) {
            (action) in
            
        }
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Введите название"
        }
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Введите описание"
        }
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    
    //MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travels.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelCell", for: indexPath) as! TravelCell
        
        let travel = travels[indexPath.row]
        
        cell.nameLabel.text = travel.name
        cell.descriptionLabel.text = travel.description
        for star in 0..<travel.getAvarageRating() {
            cell.starsRate[star].isHighlighted = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let stopVC = storyboard.instantiateViewController(identifier: "StopListViewController")as! StopListViewController
        stopVC.travel = travels[indexPath.row]
        if let tName = stopVC.travel {
            stopVC.stopsNavigationBarTitle.title = "\(tName.name)"
        }
        
        
        navigationController?.pushViewController(stopVC, animated: true)
    }
    
    //MARK: - Functions
    
    func getTravelsFromServer() {
        let database = Database.database().reference()
        database.child("travels").observeSingleEvent(of: .value) { [weak self] (snapshot) in
            guard let self = self, let value = snapshot.value as? [String: Any] else {
                return
            }
            DataBaseManager.shared.clear()
            self.travels.removeAll()
            for item in value.values {
                if let travelJson = item as? [String: Any] {
                    if let id = travelJson ["id"] as? String,
                       let name = travelJson ["name"] as? String,
                       let description = travelJson ["description"] as? String,
                       let userId = Auth.auth().currentUser?.uid {
                        let travel = Travel(userId: userId, id: id, name: name, description: description)
                        self.travels.append(travel)
                        self.tableView.reloadData()
                    }
                }
            }
            
        }
    }
    
    func sendtoServer(travel: Travel) {
        let database = Database.database().reference()
        let child = database.child("travels").child("\(travel.id)")
        dotsView.startAnimation()
        dotsView.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.dotsView.stopAnimation()
        }
        child.setValue(travel.json) { [weak self] (error, ref) in
            print(error, ref)
        }
        
    }
    
    
    func getStopsFromServer() {
        let database = Database.database().reference()
        database.child("stops").observeSingleEvent(of: .value) { [weak self] (snapshot) in
            guard let self = self, let value = snapshot.value as? [String: Any] else {
                return
            }
            for item in value.values {
                if let stopJson = item as? [String: Any] {
                    if let id = stopJson ["id"] as? String,
                       let travelId = stopJson["travelId"] as? String {
                        let stop = Stop(id: id, travelId: travelId)
                        if let name = stopJson ["name"] as? String {
                            stop.name = name
                        }
                        if let description = stopJson ["description"] as? String{
                            stop.description = description
                        }
                        if let rating = stopJson ["rating"] as? Int {
                            stop.rating = rating
                        }
                        if let locationString = stopJson ["location"] as? String {
                            let components = locationString.components(separatedBy: "-")
                            let x = Double(components.first!)!
                            let y = Double(components.last!)!
                            stop.location = CGPoint(x: x, y: y)
                        }
                        if let spentMoney = stopJson ["spentMoney"] as? Double {
                            stop.spentMoney = spentMoney
                        }
                        if let currencyString = stopJson ["currency"] as? String,
                           let currency = Currency.init(rawValue: currencyString){
                            stop.currency = currency
                        }
                        if let transportInt = stopJson ["transport"] as? Int,
                           let transport = Transport.init(rawValue: transportInt) {
                            stop.transport = transport
                        }
                        
                        for travel in self.travels {
                            if travel.id == travelId {
                                travel.stops.append(stop)
                            }
                        }
                        
                        
                    }
                }
            }
            for travel in self.travels {
                DataBaseManager.shared.saveTravelInDatabase(travel)
            }
        }
    }
    
    
    func observeTravels() {
        let realm = try! Realm()
        let travels = realm.objects(RLMTravel.self)
        travelsNotification = travels.observe { [weak self] (changes) in
            guard let self = self else { return }
            switch changes {
            case .initial(_):
                break
            case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                print("Did update Travels!")
            case .error(_):
                break
            }
        }
    }
    
//    func showBeforeTravelsLabel() {
//        let travel = travels
//        if travel == [] {
//            
//        }
//        
//        
//        let remoteConfig = RemoteConfig.remoteConfig()
//        let isNeedToShowBeforeTravelsLabel = remoteConfig["isNeedToShowLoginButton"].boolValue
//        if isNeedToShowBeforeTravelsLabel == true {
//            beforeTravelsLabel.isHidden = false
//        }
//    }
    
}
