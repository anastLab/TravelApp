//
//  RLMTravel.swift
//  HomeworkViewController
//
//  Created by AP Nastassia Pakhomava on 11/2/20.
//  Copyright © 2020 AP Nastassia Pakhomava. All rights reserved.
//

import Foundation
import RealmSwift

class RLMTravel: Object {
    @objc dynamic var userId: String = ""
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
    let stops = List<RLMStop>()
    
    override static func primaryKey() -> String? {
        return #keyPath(RLMTravel.id)
        }
}

extension RLMTravel {
    func toObject() -> Travel {
        let travel = Travel(userId: self.userId,
                            id: self.id,
                            name: self.name,
                            description: self.desc)
    
        for rlmStop in self.stops {
            let stop = Stop(id: rlmStop.id, travelId: rlmStop.travelId)
            stop.name = rlmStop.name
            stop.rating = rlmStop.rating
            stop.location = CGPoint(x: rlmStop.latitude, y: rlmStop.longitude)
            stop.spentMoney = rlmStop.spentMoney
            stop.currency = rlmStop.currency
            stop.transport = rlmStop.transport
            stop.description = rlmStop.desc
            travel.stops.append(stop)
        }
        return travel
    }
}
