//
//  DeliveryListPresenter.swift
//  Deliveries
//
//  Created by Pouya Ghasemi on 6/21/19.
//  Copyright (c) 2019 Deliveries. All rights reserved.


import UIKit

protocol DeliveryListPresentationLogic
{
    func presentDeliveries(response: DeliveryList.FetchData.Response)
    func presentCacheDeliveries(response: DeliveryList.CacheData.Response)
}

class DeliveryListPresenter: DeliveryListPresentationLogic
{
    weak var viewController: DeliveryListDisplayLogic?
    
    func presentDeliveries(response: DeliveryList.FetchData.Response)
    {
        let viewModel = DeliveryList.FetchData.ViewModel(state: response.state)
        viewController?.displayDeliveries(viewModel: viewModel)
    }
    func presentCacheDeliveries(response: DeliveryList.CacheData.Response)
    {
        var data = [Delivery]()
        if response.deliveries?.count ?? 0 > 0 {
            for item in response.deliveries! {
                var obj = Delivery()
                var location = Location()
                obj.id = item.id
                obj.desc = item.desc
                obj.imageUrl = item.imageUrl
                
                location.address = item.address
                location.lat = item.lat
                location.lng = item.lng
                
                obj.location = location
                data.append(obj)
            }
        }
       
        let viewModel = DeliveryList.CacheData.ViewModel(deliveries: data)
        viewController?.displayCacheDeliveries(viewModel: viewModel)
    }
}
