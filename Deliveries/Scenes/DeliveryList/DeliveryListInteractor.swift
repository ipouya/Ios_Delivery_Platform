//
//  DeliveryListInteractor.swift
//  Deliveries
//
//  Created by Pouya Ghasemi on 6/21/19.
//  Copyright (c) 2019 Deliveries. All rights reserved.


import UIKit

protocol DeliveryListBusinessLogic
{
    func fetchDeliveriesFromServer(request: DeliveryList.FetchData.Request)
    func fetchDeliverisFromCache(request: DeliveryList.CacheData.Request)
}

protocol DeliveryListDataStore
{
    var deliveris: [Delivery]? { get set }
}

class DeliveryListInteractor: DeliveryListBusinessLogic, DeliveryListDataStore
{
    
    var presenter: DeliveryListPresentationLogic?
    var deliveris: [Delivery]?
    
    func fetchDeliveriesFromServer(request: DeliveryList.FetchData.Request)
    {
        DataService.GetDeliveries(req: request) { res in
            let response = DeliveryList.FetchData.Response(state: res)
            switch response.state {
            case .success(let obj):
                if self.deliveris == nil {
                    self.deliveris = obj
                    RealmService.ClearCache()
                } else {
                    self.deliveris?.append(contentsOf: obj)
                }
                RealmService.InsertDeliveries(data: Delivery.toRealmModel(obj))
            default :
                print("Deliveries get data error")
            }
            self.presenter?.presentDeliveries(response: response)
        }
    }
    func fetchDeliverisFromCache(request: DeliveryList.CacheData.Request)
    {
        let response = DeliveryList.CacheData.Response(deliveries: RealmService.GetDeliveries())
        self.presenter?.presentCacheDeliveries(response: response)
    }
    
}
