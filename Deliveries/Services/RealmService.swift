//
//  RealmService.swift
//  Deliveries
//
//  Created by Pouya Ghasemi on 6/21/19.
//  Copyright © 2019 Deliveries. All rights reserved.
//

import RealmSwift


class RealmService {

    static let realm = try! Realm()
    
    static func ClearCache() {
        try! realm.write {
            realm.deleteAll()
        }
        
    }
    static func GetDeliveries() -> Results<Delivery_realm> {
        return realm.objects(Delivery_realm.self)
    }
    
    static func InsertDeliveries(data : [Delivery_realm]) {
        //DispatchQueue.global().async {
            try! realm.write {
                realm.add(data)
            }
        //}
    }
    
}
