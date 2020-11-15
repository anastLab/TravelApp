//
//  RLMStop.swift
//  HomeworkViewController
//
//  Created by AP Nastassia Pakhomava on 11/2/20.
//  Copyright © 2020 AP Nastassia Pakhomava. All rights reserved.
//

import Foundation
import RealmSwift

class RLMStop: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var travelId: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var rating: Int = 0
    @objc dynamic var latitude: Double = 0
    @objc dynamic var longitude: Double = 0
    // @objc dynamic var location: CGPoint = .zero - вместо этого, 2 строчки выше (lat..., long...)
    @objc dynamic var spentMoney: Double = 0
    @objc dynamic var desc: String = ""
    
    @objc dynamic var transportInt: Int = 0
    @objc dynamic var currencyString: String = ""
    
    var transport: Transport {
        get {
            return Transport(rawValue: transportInt)!
        }
        set {
            transportInt = newValue.rawValue
        }
    }
    
    var currency: Currency {
        get {
            return Currency(rawValue: currencyString)!
        }
        set {
            currencyString = newValue.rawValue
        }
    }
    
    override static func primaryKey() -> String? {
        return #keyPath(RLMStop.id)
    }
}
