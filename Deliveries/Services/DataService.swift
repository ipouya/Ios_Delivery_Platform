//
//  DataService.swift
//  Deliveries
//
//  Created by Pouya Ghasemi on 6/21/19.
//  Copyright © 2019 Deliveries. All rights reserved.
//

import Alamofire

class DataService {
    
    static func GetDeliveries( req: DeliveryList.FetchData.Request,callback: @escaping (_ res: RequestState<[Delivery], ErrorModel>) -> Void) {
        AFWrapper.get(MYAPP.Api.Delivery.List + "?limit=\(req.limit!)&offset=\(req.offset!)", success: { data in
            if let decodedData = try? JSONDecoder().decode([Delivery].self, from: data) {
                callback(.success(decodedData))
            } else {
                callback(.failure(ErrorModel(message: "Codable Error", code: "0")))
            }
        }, failure: { error in
            callback(.failure(error))
        })
    }
    
}
