//
//  Stop.swift
//  HomeworkViewController
//
//  Created by AP Nastassia Pakhomava on 8/27/20.
//  Copyright © 2020 AP Nastassia Pakhomava. All rights reserved.
//

import UIKit
import RealmSwift

enum Transport: Int, RealmEnum {
    case none, car, airplain, train
}

class Stop {
    var id: String
    var travelId: String
    var name: String = ""
    var rating: Int = 0
    var location: CGPoint = .zero
    var spentMoney: Double = 0
    var currency: Currency = .none
    var transport: Transport = .none
    var description: String = ""
    
    init(id: String, travelId: String) {
        self.id = id
        self.travelId = travelId
    }
    
    var json: [String: Any] {
        return ["id": id,
                "travelId": travelId,
                "name": name,
                "rating": rating,
                "location": "\(location.x)-\(location.y)",
                "spentMoney": spentMoney,
                "currency": currency.rawValue,
                "transport": transport.rawValue,
                "description": description]
    }
}
