//
//  DataBaseManager.swift
//  HomeworkViewController
//
//  Created by AP Nastassia Pakhomava on 11/2/20.
//  Copyright © 2020 AP Nastassia Pakhomava. All rights reserved.
//

import Foundation
import RealmSwift

class DataBaseManager {
    static let shared = DataBaseManager() //Синглтон
    
    var array = ["a", "b", "c"]
    
    func saveTravelInDatabase (_ travel: Travel) {
        let rlmTravel = travel.toRealm()
        let realm = try! Realm()
        try! realm.write {
         realm.add(rlmTravel, update: .all)
         }
    }
        // realm.beginWrite()
//        realm.add(rlmTravel)
//        try! realm.commitWrite() Второй способ работы с реалмом.
    
    func getTravels() -> [Travel] {
        var result: [Travel] = []
        let realm = try! Realm()
        let rlmTravels = realm.objects(RLMTravel.self) // Сюда мы сохранили все наши тревела
        for rlmTravel in rlmTravels {
            let travel = rlmTravel.toObject()
            result.append(travel)
        }
        return result
    }
    
    func clear() {
        let realm = try! Realm()
        let rlmTravels = realm.objects(RLMTravel.self)
        let rlmStops = realm.objects(RLMStop.self)
        
        try! realm.write {
        realm.delete(rlmTravels)
        realm.delete(rlmStops)
        }
    }
    
    func getObjects<T: Object>(classType: T.Type) -> [T] {
        var result: [T] = []
        let realm = try! Realm()
        let objects = realm.objects(T.self) // Сюда мы сохранили все наши тревела
        
        for object in objects {
            result.append(object)
        }
        return result
    }
    
}
