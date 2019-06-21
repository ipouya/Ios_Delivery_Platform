//
//  Delivery_realm.swift
//  Deliveries
//
//  Created by Pouya Ghasemi on 6/21/19.
//  Copyright © 2019 Deliveries. All rights reserved.
//

import RealmSwift


class Delivery_realm: Object {
    
    @objc dynamic var id : Int = 0
    @objc dynamic var desc = ""
    @objc dynamic var imageUrl = ""
    @objc dynamic var address = ""
    @objc dynamic var lat : Double = 0.0
    @objc dynamic var lng : Double = 0.0
}

