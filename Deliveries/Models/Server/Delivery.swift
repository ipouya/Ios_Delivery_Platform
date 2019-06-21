//
//  Order.swift
//  Deliveries
//
//  Created by Pouya Ghasemi on 6/21/19.
//  Copyright © 2019 Deliveries. All rights reserved.
//
import Foundation
import RealmSwift

struct Delivery:Codable{

	var desc : String!
	var id : Int!
	var imageUrl : String!
	var location : Location!
    
    private enum CodingKeys: String, CodingKey {
        case desc = "description"
        case id
        case imageUrl
        case location
    }
    
    static func toRealmModel(_ data: [Delivery]) -> [Delivery_realm] {
        var realmObjects = [Delivery_realm]()
        for item in data {
            let obj = Delivery_realm()
            obj.id = item.id
            obj.address = item.location.address ?? ""
            obj.lat = item.location.lat ?? 0
            obj.lng = item.location.lng ?? 0
            obj.desc = item.desc ?? ""
            obj.imageUrl = item.imageUrl ?? ""
            realmObjects.append(obj)
        }
        return realmObjects
    }
}
